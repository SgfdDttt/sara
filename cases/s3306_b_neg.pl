% Text
% Over the year 2018, Alice has paid $2325 in hay to Bob for agricultural labor.

% Question
% Section 3306(b) applies to the hay paid by Alice to Bob for the year 2018. Contradiction

% Facts
:- [law/semantics/init].
service_(alice_employer).
patient_(alice_employer,alice).
agent_(alice_employer,bob).
start_(alice_employer,"2018-01-01").
end_(alice_employer,"2018-12-31").
purpose_(alice_employer,"agricultural labor").
payment_(alice_pays).
agent_(alice_pays,alice).
patient_(alice_pays,bob).
start_(alice_pays,"2018-01-01").
end_(alice_pays,"2018-12-31").
purpose_(alice_pays,alice_employer).
amount_(alice_pays,2325).
means_(alice_pays,"kind").

% Test
:- \+ s3306_b(_,alice_pays,alice_employer,alice,bob,_,_,_,_,alice,bob).
:- halt.
