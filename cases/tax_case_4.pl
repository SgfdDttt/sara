% Text
% Alice has paid $3200 to Bob for domestic service done from Feb 1st, 2012 to Sep 2nd, 2012, in Baltimore, Maryland, USA. Bob has paid $4500 to Alice for work done from Apr 1st, 2012 to Dec 31st, 2012. Alice takes the standard deduction in 2012.

% Question
% How much tax does Alice have to pay in 2012? $192

% Facts
:- [statutes/prolog/init].
service_(alice_employer).
patient_(alice_employer,alice).
agent_(alice_employer,bob).
start_(alice_employer,"2012-02-01").
end_(alice_employer,"2012-09-02").
purpose_(alice_employer,"domestic service").
location_(alice_employer,"baltimore, maryland, usa").
country_("baltimore, maryland, usa","usa").
payment_(alice_pays).
agent_(alice_pays,alice).
patient_(alice_pays,bob).
start_(alice_pays,"2012-09-02").
purpose_(alice_pays,alice_employer).
amount_(alice_pays,3200).
service_(bob_employer).
patient_(bob_employer,bob).
agent_(bob_employer,alice).
start_(bob_employer,"2012-04-01").
end_(bob_employer,"2012-12-31").
payment_(bob_pays).
agent_(bob_pays,bob).
patient_(bob_pays,alice).
start_(bob_pays,"2012-09-02").
purpose_(bob_pays,bob_employer).
amount_(bob_pays,4500).

% Test
:- tax(alice,2012,192).
:- halt.
