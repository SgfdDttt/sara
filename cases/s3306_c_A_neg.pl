% Text
% Alice has paid $3200 to Bob for work done from Feb 1st, 2017 to Sep 2nd, 2017, in Toronto, Ontario, Canada.

% Question
% Section 3306(c)(A) applies to Alice employing Bob for the year 2017. Contradiction

% Facts
:- [law/semantics/init].
service_(alice_employer).
patient_(alice_employer,alice).
agent_(alice_employer,bob).
start_(alice_employer,"2017-02-01").
end_(alice_employer,"2017-09-02").
location_(alice_employer,"toronto, ontario, canada").
country_("toronto, ontario, canada","canada").
payment_(alice_pays).
agent_(alice_pays,alice).
patient_(alice_pays,bob).
start_(alice_pays,"2017-09-02").
purpose_(alice_pays,alice_employer).
amount_(alice_pays,3200).

% Test
:- \+ s3306_c_A(_,alice,bob,_).
:- halt.
