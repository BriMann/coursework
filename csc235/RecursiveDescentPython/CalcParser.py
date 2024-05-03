#!/usr/bin/env python3

# Source: https://www.booleanworld.com/building-recursive-descent-parsers-definitive-guide/#Building_a_base_for_the_Recursive_Descent_Parser_in_Python

class ParseError(Exception):
    def __init__(self, pos, msg, *args):
        self.pos = pos
        self.msg = msg
        self.args = args

    def __str__(self):
        return '%s at position %s' % (self.msg % self.args, self.pos)

class Parser:
    def __init__(self):
        self.cache = {}

    def parse(self, text):
        self.text = text
        self.pos = -1
        self.len = len(text) - 1
        rv = self.start()
        self.assert_end()
        return rv

    def assert_end(self):
        if self.pos < self.len:
            raise ParseError(
                self.pos + 1,
                'Expected end of string but got %s',
                self.text[self.pos + 1]
            )

    def eat_whitespace(self):
        while self.pos < self.len and self.text[self.pos + 1] in " \f\v\r\t\n":
            self.pos += 1

    def split_char_ranges(self, chars):
        try:
            return self.cache[chars]
        except KeyError:
            pass

        rv = []
        index = 0
        length = len(chars)

        while index < length:
            if index + 2 < length and chars[index + 1] == '-':
                if chars[index] >= chars[index + 2]:
                    raise ValueError('Bad character range')

                rv.append(chars[index:index + 3])
                index += 3
            else:
                rv.append(chars[index])
                index += 1

        self.cache[chars] = rv
        return rv

    def char(self, chars=None):
        if self.pos >= self.len:
            raise ParseError(
                self.pos + 1,
                'Expected %s but got end of string',
                'character' if chars is None else '[%s]' % chars
            )

        next_char = self.text[self.pos + 1]
        if chars == None:
            self.pos += 1
            return next_char

        for char_range in self.split_char_ranges(chars):
            if len(char_range) == 1:
                if next_char == char_range:
                    self.pos += 1
                    return next_char
            elif char_range[0] <= next_char <= char_range[2]:
                self.pos += 1
                return next_char

        raise ParseError(
            self.pos + 1,
            'Expected %s but got %s',
            'character' if chars is None else '[%s]' % chars,
            next_char
        )

    def keyword(self, *keywords):
        self.eat_whitespace()
        if self.pos >= self.len:
            raise ParseError(
                self.pos + 1,
                'Expected %s but got end of string',
                ','.join(keywords)
            )

        for keyword in keywords:
            low = self.pos + 1
            high = low + len(keyword)

            if self.text[low:high] == keyword:
                self.pos += len(keyword)
                self.eat_whitespace()
                return keyword

        raise ParseError(
            self.pos + 1,
            'Expected %s but got %s',
            ','.join(keywords),
            self.text[self.pos + 1],
        )

    def match(self, *rules):
        self.eat_whitespace()
        last_error_pos = -1
        last_exception = None
        last_error_rules = []

        for rule in rules:
            initial_pos = self.pos
            try:
                rv = getattr(self, rule)()
                self.eat_whitespace()
                return rv
            except ParseError as e:
                self.pos = initial_pos

                if e.pos > last_error_pos:
                    last_exception = e
                    last_error_pos = e.pos
                    last_error_rules.clear()
                    last_error_rules.append(rule)
                elif e.pos == last_error_pos:
                    last_error_rules.append(rule)

        if len(last_error_rules) == 1:
            raise last_exception
        else:
            raise ParseError(
                last_error_pos,
                'Expected %s but got %s',
                ','.join(last_error_rules),
                self.text[last_error_pos]
            )

    def maybe_char(self, chars=None):
        try:
            return self.char(chars)
        except ParseError:
            return None

    def maybe_match(self, *rules):
        try:
            return self.match(*rules)
        except ParseError:
            return None

    def maybe_keyword(self, *keywords):
        try:
            return self.keyword(*keywords)
        except ParseError:
            return None

class CalcParser(Parser):
    def start(self):
        """ S -> E """
        return self.expression()

    def expression(self):
        """ E -> T E' """
        rv = self.match('term')
        while True:
            exptail = self.match('exptail')
            if not exptail:
                break
            rv += exptail
        return rv

    def exptail(self):
        """ E' -> eps | + T E' | - T E' """
        op = self.maybe_keyword('+', '-')
        if op is None:
            return
        else:
            term = self.match('term')
            if op == '-':
                term *= -1
            return term

    def term(self):
        """ T -> F T' """
        rv = self.match('factor')
        while True:
            termtail = self.match('termtail')
            if not termtail:
                break
            rv *= termtail
        return rv

    def termtail(self):
        """ T' -> eps | * F T' | / F T' """
        op = self.maybe_keyword('*', '/')
        if op is None:
            return
        else:
            factor = self.match('factor')
            if op == '/':
                factor = 1/factor
            return factor


    def factor(self):
        """ F -> 0 | 1 | 2 | 3 | (E) """
        if self.maybe_keyword('('):
            rv = self.match('expression')
            self.keyword(')')

            return rv

        return self.match('number')

    def number(self):
        """ This one is really more a lexer function, but
        the design of this parser is such that lexing and
        parsing are not separated the way we talked about before."""
        chars = []

        sign = self.maybe_keyword('+', '-')
        if sign is not None:
            chars.append(sign)

        chars.append(self.char('0-9'))

        while True:
            char = self.maybe_char('0-9')
            if char is None:
                break

            chars.append(char)

        if self.maybe_char('.'):
            chars.append('.')
            chars.append(self.char('0-9'))

            while True:
                char = self.maybe_char('0-9')
                if char is None:
                    break

                chars.append(char)

        rv = float(''.join(chars))
        return rv

parser = CalcParser()

while True:
    try:
        print(parser.parse(input('> ')))
    except KeyboardInterrupt:
        print()
    except (EOFError, SystemExit):
        print()
        break
    except (ParseError, ZeroDivisionError) as e:
        print('Error: %s' % e)
