% Text
% Alice has paid $3200 to Bob for work done from Feb 1st, 2017 to Sep 2nd, 2017, in Caracas, Venezuela, for domestic service. Alice is an American employer.

% Question
% Section 3306(c)(1) applies to Alice employing Bob for the year 2017. Contradiction

% Facts
:- [statutes/prolog/init].
service_(alice_employer).
patient_(alice_employer,alice).
agent_(alice_employer,bob).
start_(alice_employer,"2017-02-01").
end_(alice_employer,"2017-09-02").
location_(alice_employer,"caracas, venezuela").
country_("caracas, venezuela", "venezuela").
purpose_(alice_employer,"domestic service").
payment_(alice_pays).
agent_(alice_pays,alice).
patient_(alice_pays,bob).
start_(alice_pays,"2017-09-02").
purpose_(alice_pays,alice_employer).
amount_(alice_pays,3200).
american_employer_(alice_is_american_employer).
agent_(alice_is_american_employer,alice).
citizenship_(bob_is_american).
agent_(bob_is_american,bob).
patient_(bob_is_american,"usa").

% Test
:- \+ s3306_c_1(_,alice,bob,2017).
:- halt.
