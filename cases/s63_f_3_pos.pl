% Text
% In 2017, Alice was paid $33200. Alice was born March 2nd, 1950 and Bob was born March 3rd, 1955.

% Question
% Under section 63(f)(3), Alice's additional standard deduction in 2017 is equal to $750. Entailment

% Facts
:- [statutes/prolog/init].
payment_(alice_is_paid).
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2017-12-31").
amount_(alice_is_paid,33200).
birth_(alice_is_born).
agent_(alice_is_born,alice).
start_(alice_is_born,"1950-03-02").
end_(alice_is_born,"1950-03-02").
birth_(bob_is_born).
agent_(bob_is_born,bob).
start_(bob_is_born,"1955-03-03").
end_(bob_is_born,"1955-03-03").

% Test
:- s63_f_3(alice,2017,750).
:- halt.
