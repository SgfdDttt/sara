% Text
% Alice and Charlie have been married since 2 Feb 2015. Bob counts as Alice's dependent under section 152(c)(1) for 2015.

% Question
% Alice can claim an exemption with Bob the dependent for 2015 under section 151(c). Entailment

% Facts
:- discontiguous s152_c_1/3.
:- [statutes/prolog/init].
marriage_(alice_and_charlie).
agent_(alice_and_charlie,alice).
agent_(alice_and_charlie,charlie).
start_(alice_and_charlie,"2015-02-02").
s152_c_1(bob,alice,2015).

% Test
:- s151_c(alice,bob,_,2015).
:- halt.
