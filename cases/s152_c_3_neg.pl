% Text
% Alice was born January 10th, 1992. Bob was born January 31st, 1984. Alice adopted Bob on March 4th, 2018.

% Question
% Bob satisfies section 152(c)(3) with Alice claiming Bob as a qualifying child for the year 2019. Contradiction

% Facts
:- [statutes/prolog/init].
birth_(alice_is_born).
agent_(alice_is_born,alice).
start_(alice_is_born,"1992-01-10").
end_(alice_is_born,"1992-01-10").
birth_(bob_is_born).
agent_(bob_is_born,bob).
start_(bob_is_born,"1984-01-31").
end_(bob_is_born,"1984-01-31").
son_(alice_and_bob).
agent_(alice_and_bob,bob).
patient_(alice_and_bob,alice).
start_(alice_and_bob,"2018-03-04").

% Test
:- \+ s152_c_3(bob,alice,2019).
:- halt.
