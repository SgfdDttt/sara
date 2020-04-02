%§68. Overall limitation on itemized deductions
s68(Individual,Amount_deductions_in,Amount_deductions_out,Year) :-
    (
        s68_f(Year),
        Amount_deductions_out is Amount_deductions_in
    );
    (
        \+ s68_f(Year),
        (
            s68_a(Individual,Amount_deductions_in,Reduction,Year),
            Amount_deductions_out is Amount_deductions_in-Reduction
        );
        (
            \+ s68_a(Individual,Amount_deductions_in,_,Year),
            Amount_deductions_out is Amount_deductions_in
        )
    ).

%(a) General rule

%In the case of an individual whose adjusted gross income exceeds the applicable amount, the amount of the itemized deductions otherwise allowable for the taxable year shall be reduced by the lesser of-
s68_a(Individual,Amount_itemized_deductions,Reduction,Year) :-
    gross_income(Individual,Year,Gross_income),
    s68_b(Individual,Applicable_amount,Year),
    Gross_income>Applicable_amount,
    s68_a_1(Gross_income,Applicable_amount,Reduction1),
    s68_a_2(Amount_itemized_deductions,Reduction2),
    Reduction is min(Reduction1,Reduction2).

%(1) 3 percent of the excess of adjusted gross income over the applicable amount, or
s68_a_1(Adjusted_gross_income,Applicable_amount,Reduction) :-
    X is 3*(Adjusted_gross_income-Applicable_amount),
    Reduction is round(X rdiv 100).

%(2) 80 percent of the amount of the itemized deductions otherwise allowable for such taxable year.
s68_a_2(Amount_itemized_deductions,Reduction) :-
    X is 80*Amount_itemized_deductions,
    Reduction is round(X rdiv 100).


%(b) Applicable amount
s68_b(Individual,Applicable_amount,Year) :-
    s68_b_1_A(Individual,Applicable_amount,Year);
    s68_b_1_B(Individual,Applicable_amount,Year);
    s68_b_1_C(Individual,Applicable_amount,Year);
    s68_b_1_D(Individual,Applicable_amount,Year).

%(1) In general

%For purposes of this section, the term "applicable amount" means-
amount("A",Amount) :-
    Amount is 300000.
amount("B",Amount) :-
    Amount is 275000.
amount("C",Amount) :-
    Amount is 250000.
amount("D",Amount) :-
    amount("A",Amount_A),
    Amount is round(Amount_A rdiv 2).

%(A) $300,000 in the case of a joint return or a surviving spouse (as defined in section 2(a)),
s68_b_1_A(Individual,Applicable_amount,Year) :-
    (
        (
            s7703(Individual,Spouse,_,_,_,_,_,_,Year),
            joint_return_(Joint_return),
            agent_(Joint_return,Individual),
            agent_(Joint_return,Spouse),
            first_day_year(Year,First_day_year),
            start_(Joint_return,First_day_year),
            last_day_year(Year,Last_day_year),
            end_(Joint_return,Last_day_year)
        );
        s2_a(Individual,_,_,_,Year)
    ),
    amount("A",Applicable_amount).

%(B) $275,000 in the case of a head of household (as defined in section 2(b)),
s68_b_1_B(Individual,Applicable_amount,Year) :-
    s2_b(Individual,_,_,Year),
    amount("B",Applicable_amount).

%(C) $250,000 in the case of an individual who is not married and who is not a surviving spouse or head of household, and
s68_b_1_C(Individual,Applicable_amount,Year) :-
    \+ s7703(Individual,_,_,_,_,_,_,_,Year),
    \+ s2_a(Individual,_,_,_,Year), 
    \+ s2_b(Individual,_,_,Year),
    amount("C",Applicable_amount).

%(D) ½ the amount applicable under subparagraph (A) in the case of a married individual filing a separate return.
s68_b_1_D(Individual,Applicable_amount,Year) :-
    s7703(Individual,Spouse,_,_,_,_,_,_,Year),
    \+ (
        joint_return_(Joint_return),
        agent_(Joint_return,Individual),
        agent_(Joint_return,Spouse),
        first_day_year(Year,First_day_year),
        start_(Joint_return,First_day_year),
        last_day_year(Year,Last_day_year),
        end_(Joint_return,Last_day_year)
    ),
    amount("D",Applicable_amount).

%For purposes of this paragraph, marital status shall be determined under section 7703.

%(f) Section not to apply

%This section shall not apply to any taxable year beginning after December 31, 2017, and before January 1, 2026.
s68_f(Year) :-
    between(2018,2025,Year).
