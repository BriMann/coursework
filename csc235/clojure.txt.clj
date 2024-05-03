(ns log-levels
  (:require [clojure.string :as str]))
;; I had to look up how to use the trim and split functions before applying them to this.
(defn message
  "Takes a string representing a log line
   and returns its message with whitespace trimmed."
  [s]
  (str/trim (last (str/split s #": ")))
  )
;; Since all I had to do was convert the string to lower case, I had to reformat the string as a set of characters
;; Then I had to look up how to use the lower case function
(defn log-level
  "Takes a string representing a log line
   and returns its level in lower-case."
  [s]
    (let [l (first (str/split s #": "))]
    (str/lower-case
      (subs l 1 (- (count l) 1))
      )
    )
  )
;; Since I had to format the string, I had to look up how to use the format funciton
;; Then it was a matter of calling the other two functions to make it work
(defn reformat
  "Takes a string representing a log line and formats it
   with the message first and the log level in parentheses."
  [s]
  (format "%s (%s)" (message s) (log-level s))
  )




(ns armstrong-numbers)
"Checks if a number is an armstrong number by taking each digit, raising them to the power of the number of digits
then adding them together to get number again"
;; I knew I had to interpret the number as a string in order to seperate the characters
;; As well as redefine it as a sequence in order to keep the digits seperate to define the functions
;; Then it was a matter of figuring out how to use a power function and how to add them all together
(defn armstrong? [num] ;; <- arglist goes here
  ;; your code goes here
  (->> (str num)
       seq
       (map str)
       (map read-string)
       (map #(reduce * (repeat (count (str num)) %)))
       (reduce +)
       (= num)))





(ns sublist)
"Checks if either list is a sublist, superlist, equal, of unequal"
;; Since I had to check for individual elements to determine if the lists are of a certain type
;; I needed to check if each element of one list existed in the other, to determine if they are sublists or superlists
;; as well as make sure the lists were in increasing order 
(defn classify [list1 list2] ;; <- arglist goes here
      ;; your code goes here
  (cond (= list1 list2) :equal
        (= [] list1) :sublist
        (= [] list2) :superlist
        (some #(= list1 %) (partition (count list1) 1 list2)) :sublist
        (some #(= list2 %) (partition (count list2) 1 list1)) :superlist
        :else :unequal))





(ns all-your-base)
"takes a number and converts a sequence of digits from one base to another base"
;;needed a function to convert a number from a lower base to a higher base
(defn- to-base-10 [n-list from-base]
  (reduce #(+ (* from-base %1) %2) 0 n-list))
;;needed a function to convert a number from a higher base to a lower base
(defn- from-base-10 [n to-base]
  (loop [n n res ()]
    (let [q (quot n to-base)
          res (cons (rem n to-base) res)]
      (if (zero? q) res (recur q res)))))
;; needed to make sure the input was valid and that it goes one digit at a time
(defn- guard [n-list from-base to-base]
  (and (seq n-list)
       (> to-base 1)
       (every? #(and (number? %)
                     (<= 0 % (dec from-base)))
               n-list)))
;; this is where it will all starts
(defn convert [from-base n-list to-base]
  (when (guard n-list from-base to-base)
    (-> n-list
        (to-base-10 from-base)
        (from-base-10 to-base))))




(ns collatz-conjecture)
"applies the collatz conjecture to a given integer until it evetually reaches one"
;; didn't know I could apply a loop function until I looked it up.
;; Made the rest of the problem much easier to implement
(defn collatz [num] ;; <- arglist goes here
  ;; your code goes here
  (loop [num   num
         total 0]
    (cond
      (< num 1)   (throw "Can't deal with negativity")
      (= num 1)   total
      (even? num) (recur (/ num 2)       (inc total))
      :else       (recur (+ (* 3 num) 1) (inc total)))))