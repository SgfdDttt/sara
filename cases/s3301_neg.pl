% Text
% Alice is an employer under section 3306(a) for the year 2015 and 2016, and she has paid $453009 in total wages in 2015, and $443870 in 2016.

% Question
% Alice has to pay $26362 in excise tax for the year 2016 under section 3301. Contradiction

% Facts
:- discontiguous total_wages_employer/4.
:- discontiguous s3306_a/3.
:- [statutes/prolog/init].
s3306_a(alice,Year,_) :- between(2015,2016,Year).
total_wages_employer(alice,453009,"2015-01-01","2015-12-31").
total_wages_employer(alice,443870,"2016-01-01","2016-12-31").

% Test
:- \+ s3301(alice,2016,_,26362).
:- halt.
