% Text
% In 2012, Alice was paid $54268 in remuneration. In addition, Alice has paid $11571 to Bob for work done from Feb 1st, 2012 to Sep 2nd, 2012, in Caracas, Venezuela. Alice is an American employer, and Bob is an American citizen. Bob takes the standard deduction in 2012.

% Question
% How much tax does Bob have to pay in 2012? $986

% Facts
:- [statutes/prolog/init].
payment_(alice_income).
patient_(alice_income,alice).
start_(alice_income,"2012-12-31").
amount_(alice_income,54268).
service_(alice_employer).
patient_(alice_employer,alice).
agent_(alice_employer,bob).
start_(alice_employer,"2012-02-01").
end_(alice_employer,"2012-09-02").
location_(alice_employer,"caracas, venezuela").
country_("caracas, venezuela","venezuela").
payment_(alice_pays).
agent_(alice_pays,alice).
patient_(alice_pays,bob).
start_(alice_pays,"2012-09-02").
purpose_(alice_pays,alice_employer).
amount_(alice_pays,11571).
american_employer_(alice_is_american_employer).
agent_(alice_is_american_employer,alice).
citizenship_(bob_is_american).
agent_(bob_is_american,bob).
patient_(bob_is_american,"usa").

% Test
:- tax(bob,2012,986).
:- halt.
