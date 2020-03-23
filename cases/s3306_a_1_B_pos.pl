% Text
% Alice has employed Bob on various occasions during the year 2017:
% - Jan 24
% - Feb 4
% - Mar 3
% - Mar 19
% - Apr 2
% - May 9
% - Oct 15
% - Oct 25
% - Nov 8
% - Nov 22
% - Dec 1
% - Dec 3

% Question
% Section 3306(a)(1)(B) applies to Alice for the year 2017. Entailment

% Facts
:- discontiguous s3306_c/6.
:- [statutes/prolog/init].
s3306_c(Employment_event,alice,bob,_,Day,_) :-
    member(Day, ["2017-01-24", "2017-02-04", "2017-03-03", "2017-03-19","2017-04-02","2017-05-09","2017-10-15","2017-10-25","2017-11-08","2017-11-22","2017-12-01","2017-12-03"]),
    atom_concat("alice_employer_",Day,Employment_event).

% Test
:- s3306_a_1_B(alice,2017).
:- halt.
