% Text
% Alice has paid $23200 in remuneration to Bob for work done from Feb 1st, 2017 to Sep 2nd, 2017, in Caracas, Venezuela, for agricultural labor. Bob is an American citizen. Alice is an American employer. In 2017, Alice maintains as her principal place of abode a house where her mother Dorothy lives. Alice's gross income for the year 2017 is $197407. Alice takes the standard deduction.

% Question
% How much tax does Alice have to pay in 2017? $55528

% Facts
:- [statutes/prolog/init].
service_(alice_employer).
patient_(alice_employer,alice).
agent_(alice_employer,bob).
start_(alice_employer,"2017-02-01").
end_(alice_employer,"2017-09-02").
location_(alice_employer,"caracas, venezuela").
country_("caracas, venezuela", "venezuela").
purpose_(alice_employer,"agricultural labor").
payment_(alice_pays).
agent_(alice_pays,alice).
patient_(alice_pays,bob).
start_(alice_pays,"2017-09-02").
purpose_(alice_pays,alice_employer).
amount_(alice_pays,23200).
american_employer_(alice_is_american_employer).
agent_(alice_is_american_employer,alice).
citizenship_(bob_is_american).
agent_(bob_is_american,bob).
patient_(bob_is_american,"usa").
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,alice_house).
start_(alice_residence,"2017-01-01").
end_(alice_residence,"2017-12-31").
payment_(alice_maintains_house).
agent_(alice_maintains_house,alice).
amount_(alice_maintains_house,1).
start_(alice_maintains_house,"2017-01-01").
purpose_(alice_maintains_house,alice_house).
mother_(dorothy_is_mother).
agent_(dorothy_is_mother,dorothy).
patient_(dorothy_is_mother,alice).
residence_(dorothy_residence).
agent_(dorothy_residence,dorothy).
patient_(dorothy_residence,alice_house).
start_(dorothy_residence,"2017-01-01").
end_(dorothy_residence,"2017-12-31").
income_(alice_income_2017).
agent_(alice_income_2017,alice).
start_(alice_income_2017,"2017-12-31").
amount_(alice_income_2017,197407).

% Test
:- tax(alice,2017,55528).
:- halt.
