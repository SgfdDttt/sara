% Text
% Bob is Charlie and Dorothy's son, born April 15th, 2015. Alice married Charlie on August 8th, 2018. Alice was paid $73200 in 2020 as an employee of the United States Government in Arlington, Virginia, USA. Alice files a separate return and takes the standard deduction. Since 2019, Alice, Bob and Charlie live in a house maintained by Alice and Charlie.

% Question
% How much tax does Alice have to pay in 2020? $15236

% Facts
:- [statutes/prolog/init].
son_(bob_is_son).
agent_(bob_is_son,bob).
patient_(bob_is_son,charlie).
patient_(bob_is_son,dorothy).
start_(bob_is_son,"2015-04-15").
marriage_(alice_and_charlie).
agent_(alice_and_charlie,alice).
agent_(alice_and_charlie,charlie).
start_(alice_and_charlie,"2018-08-08").
service_(alice_employed).
patient_(alice_employed,"united states government").
agent_(alice_employed,alice).
start_(alice_employed,"2020-01-01").
end_(alice_employed,"2020-12-31").
location_(alice_employed,"arlington").
location_(alice_employed,"virginia").
location_(alice_employed,"usa").
payment_(alice_is_paid).
agent_(alice_is_paid,"united states government").
patient_(alice_is_paid,alice).
start_(alice_is_paid,"2020-12-31").
purpose_(alice_is_paid,alice_employed).
amount_(alice_is_paid,73200).
residence_(alice_residence).
agent_(alice_residence,alice).
patient_(alice_residence,abc_house).
start_(alice_residence,"2019-01-01").
residence_(bob_residence).
agent_(bob_residence,bob).
patient_(bob_residence,abc_house).
start_(bob_residence,"2019-01-01").
residence_(charlie_residence).
agent_(charlie_residence,charlie).
patient_(charlie_residence,abc_house).
start_(charlie_residence,"2019-01-01").
payment_(alice_maintains_house_2019).
agent_(alice_maintains_house_2019,alice).
amount_(alice_maintains_house_2019,1).
start_(alice_maintains_house_2019,"2019-12-31").
payment_(alice_maintains_house_2020).
agent_(alice_maintains_house_2020,alice).
amount_(alice_maintains_house_2020,1).
start_(alice_maintains_house_2020,"2020-12-31").
payment_(charlie_maintains_house_2019).
agent_(charlie_maintains_house_2019,charlie).
amount_(charlie_maintains_house_2019,1).
start_(charlie_maintains_house_2019,"2019-12-31").
payment_(charlie_maintains_house_2020).
agent_(charlie_maintains_house_2020,charlie).
amount_(charlie_maintains_house_2020,1).
start_(charlie_maintains_house_2020,"2020-12-31").

% Test
:- tax(alice,2020,15236).
:- halt.
