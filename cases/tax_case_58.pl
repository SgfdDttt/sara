% Text
% Alice got married on May 30th, 2014. Alice files a joint return with her spouse for 2017 and they take the standard deduction. Alice's gross income for the year 2017 is $103272 while her spouse had no income. Alice has paid $3200 to her brother Bob for work done from Feb 1st, 2017 to Sep 2nd, 2017, in Baltimore, Maryland, USA.

% Question
% How much tax does Alice have to pay in 2017? $21635

% Facts
:- [statutes/prolog/init].
marriage_(alice_marriage).
agent_(alice_marriage,alice).
agent_(alice_marriage,spouse).
start_(alice_marriage,"2014-05-30").
joint_return_(joint_return).
agent_(joint_return,alice).
agent_(joint_return,spouse).
start_(joint_return,"2017-01-01").
end_(joint_return,"2017-12-31").
income_(alice_income_2017).
agent_(alice_income_2017,alice).
amount_(alice_income_2017,103272).
start_(alice_income_2017,"2017-12-31").
service_(alice_employer).
patient_(alice_employer,alice).
agent_(alice_employer,bob).
start_(alice_employer,"2017-02-01").
end_(alice_employer,"2017-09-02").
location_(alice_employer,"baltimore").
location_(alice_employer,"maryland").
location_(alice_employer,"usa").
payment_(alice_pays).
agent_(alice_pays,alice).
patient_(alice_pays,bob).
start_(alice_pays,"2017-09-02").
purpose_(alice_pays,alice_employer).
amount_(alice_pays,3200).
sibling_(bob_brother_of_alice).
agent_(bob_brother_of_alice,bob).
patient_(bob_brother_of_alice,alice).

% Test
:- tax(alice,2017,21635).
:- halt.
