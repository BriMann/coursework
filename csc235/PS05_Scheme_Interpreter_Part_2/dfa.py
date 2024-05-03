def DFA_transitions(states, alphabets):
    automata_transitions = {}
    for state in states:
        automata_transitions[state] = {}
        for alphabet in alphabets:
            automata_transitions[state][alphabet] = "q1"
    return automata_transitions
    
def NFA_transitions(states, alphabets):
    automata_transitions = {}
    for state in states:
        automata_transitions[state] = {}
        for alphabet in alphabets:
            automata_transitions[state][alphabet] = {"q1", "q2"}
    return automata_transitions

def powerset(elems):
    """Returns a set representing the power set of `elems`.
    Note that this can be very expensive (time and space)
    since the size of the power set is exponential in the
    size of `elems`."""

    elems_list = list(elems) # need to use indexing
    n = len(elems)
    powerset_size = 2**n
    result = set()
    for i in range(powerset_size):
        # item j from elems is in the ith element
        # of the powerset if the binary rep of i
        # has a 1 in position j
        ith_subset = set()
        for j in range(n):
            if (i & (1 << j) > 0):
                ith_subset.add(elems_list[j])
        result.add(frozenset(ith_subset))
    return result

class DFA(object):
    
    def __init__(self, Dstates, Dalphabet, Dstart_state, Dtransitions, Daccept_states):
        self.Dstates = set(Dstates)
        self.Dalphabet = set(Dalphabet)
        self.Dstart_state = str(Dstart_state)
        self.Dtransitions = DFA_transitions(Dstates,Dalphabet)
        self.Daccept_states = set(Daccept_states)
    
    def __repr__(self):
        """print an array table of the DFA. Convert all possible transitions into lists with lambda loop.
        Define table with states as rows and alphabet as columns"""
        return(f"A = {self.Dstates}, {self.Dalphabet}, {self.Dstart_state}, {self.Dtransitions}, {self.Daccept_states}")
    
    def DFA_do_delta(self, state, alphabet):
        return self.Dtransitions[state][alphabet]
    
        
    def DFA_delta_hat(self, Daccept_states, sequence):
        "perform the delta hat function on the DFA"
        initial_state = self.Dstart_state
        for s in sequence:
            initial_state = self.Dtransitions[initial_state][s]
        return initial_state in Daccept_states
        
        
    def DFA_to_NFA(self):
        "Since any DFA can be an NFA, just initiate a DFA object as an NFA object"
        return self.NFA(self.Dstates, self.Dalphabet, self.Dstart_state, self.Daccept_state)
        
class NFA(object):
    
    def __init__(self, Nstates, Nalphabet, Nstart_states, Ntransitions, Naccept_states):
        self.Nstates = set(Nstates)
        self.Nalphabet = set(Nalphabet)
        self.Nstart_state = str(Nstart_states)
        self.Ntransitions = NFA_transitions(Nstates, Nalphabet)
        self.Naccept_states = str(Naccept_states)
        
        
    def __repr__(self):
        """print an array table of the NFA. Convert all possible transitions into lists with lambda loop.
        Define table with states as rows and alphabet as columns"""
        return(f"A = {self.Nstates}, {self.Nalphabet}, {self.Nstart_state}, {self.Ntransitions}, {self.Naccept_states}")
        
    def NFA_do_delta(self, state, alphabet = None):
        if alphabet is None or 'epsilon':
            return self.Ntransitions[state]['epsilon']
        else:
            return self.Ntransitions[state][alphabet]
        
    def NFA_delta_hat(self, Naccept_states, sequence):
        "performs the delta hat function on the NFA"
        temp = []
        for s in self.Nstates:
            temp.append(list(self.NFA_do_delta(s,sequence[0])))
        delta_union = set()
        for x in temp:
            delta_union = delta_union.union(x)
        #delta_union = (set(temp)|set(temp))
        if len(sequence) == 1 and Naccept_states in delta_union:
            return True
        elif len(sequence) > 1:
            return self.NFA_delta_hat(Naccept_states, sequence[1:])
        else:
            return False
        
    def NFA_to_DFA(self, transitions, accept_state, states, alphabet):
        "give all possible state combos with no repeats"
        "Go through each state and alphabet to find all other states it can reach"
        "Determines all states accessible from the start state"
        "Determines all accept states"
        new_states = powerset(states)
        new_dfa = {}
        for states in new_states:
            new_dfa[states] = {}
            for letters in alphabet:
                if states is None:
                    new_dfa[states][letters] = None
                else:
                    temp = []
                    for substates in states:
                        temp.append(list(self.NFA_do_delta(substates,letters)))
                    union = set()
                    for x in temp:
                        union = union.union(x)
                    new_dfa[states][letters] = union
        return new_dfa
                    
   
        
Q = ('q0', 'q1', 'q2')
E = ('a', 'b', 'c', 'd', 'e')
F = ('q1')
delta =  DFA_transitions(Q,E)
S = ('q0')
D = DFA(Q,E,S, delta,F)
print(D)
Hat = D.DFA_delta_hat(S, 'aabecdb')
print(Hat)
power = powerset(Q)
print(power)
val = D.DFA_do_delta('q0','c')
print(val)
A = {'q0', 'q1', 'q2', 'q2', 'q2', 'q0', 'q1'}
B = (A|A)
print(B)
Q_2 = ('q0', 'q1', 'q2')
E_2 = ('a', 'b', 'c', 'd', 'e', 'epsilon')
F_2 = ('q1')
delta_2 =  DFA_transitions(Q,E)
S_2 = ('q0')
N = NFA(Q_2,E_2,S_2, delta_2,F_2)
print(N)
val_2 = N.NFA_do_delta(F_2)
print(val_2)
Hat_2 = N.NFA_delta_hat(S_2, 'abced')
print(Hat_2)
new_DFA = N.NFA_to_DFA(delta_2, S_2, Q_2, E_2)
print(new_DFA)