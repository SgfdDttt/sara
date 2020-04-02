%§151. Allowance of deductions for personal exemptions
s151(Individual,Deductions,Person_list,Exemptions_list,Year) :-
	first_day_year(Year,First_day_year),
    last_day_year(Year,Last_day_year),
    (
        ( % if the individual is filing a joint return with his spouse, sum both incomes
            s7703(Individual,Spouse,_,_,_,_,_,_,Year),
            joint_return_(Joint_return),
            agent_(Joint_return,Individual),
            agent_(Joint_return,Spouse),
            start_(Joint_return,First_day_year),
            end_(Joint_return,Last_day_year),
            s151_individual(Individual,Total_ex_taxpayer,Indiv_list_taxpayer,Ex_list_taxpayer,Year),
            s151_individual(Spouse,Total_ex_spouse,Indiv_list_spouse,Ex_list_spouse,Year),
            Deductions is Total_ex_taxpayer+Total_ex_spouse,
            append(Indiv_list_taxpayer,Indiv_list_spouse,Person_list),
            append(Ex_list_taxpayer,Ex_list_spouse,Exemptions_list)
        );
        ( % otherwise, it's just the individual's income
            \+ (
                s7703(Individual,Spouse,_,_,_,_,_,_,Year),
                joint_return_(Joint_return),
                agent_(Joint_return,Individual),
                agent_(Joint_return,Spouse),
                start_(Joint_return,First_day_year),
                end_(Joint_return,Last_day_year)
            ),
            s151_individual(Individual,Deductions,Person_list,Exemptions_list,Year)
        )
    ).

s151_individual(Individual,Deductions,Person_list,Exemptions_list,Year) :-
    s151_b(Individual,Exemption_amount_self,Year),
    findall(
        (Person,Exemption),
        s151_b(Individual,Person,Exemption,Year),
        List_b
    ),
    append([(Individual,Exemption_amount_self)],List_b,List_b_2),
    list_to_set(List_b_2,Set_b),
    findall(
        (Person,Exemption),
        s151_c(Individual,Person,Exemption,Year),
        List_c
    ),
    list_to_set(List_c,Set_c),
    append(Set_b,Set_c,List_all_exemptions),
    findall(
        Person,
        member((Person,_),List_all_exemptions),
        Person_list
    ),
    findall(
        Exemption,
        member((_,Exemption),List_all_exemptions),
        Exemptions_list
    ),
    sum_list(Exemptions_list,Deductions).

%(a) Allowance of deductions

%In the case of an individual, the exemptions provided by this section shall be allowed as deductions in computing taxable income.
s151_a(Individual,Exemptions,Year) :- % simpler interface
    s151(Individual,Exemptions,_,_,Year).

%(b) Taxpayer and spouse

%An exemption of the exemption amount for the taxpayer; and an additional exemption of the exemption amount for the spouse of the taxpayer if a joint return is not made by the taxpayer and his spouse, and if the spouse, for the calendar year in which the taxable year of the taxpayer begins, has no gross income and is not the dependent of another taxpayer.
s151_b_applies(_,_). % defining these auxiliary functions allows to test whether "a deduction under this section is allowable" without going into an infinite loop (b) -> (d) -> (b)...
s151_b_applies(Taxpayer,Spouse,Year) :-
    s7703(Taxpayer,Spouse,_,_,_,_,_,_,Year),
    \+ ( % if a joint return is not made by the taxpayer and his spouse
       joint_return_(Joint_return),
       agent_(Joint_return,Taxpayer),
       agent_(Joint_return,Spouse),
       first_day_year(Year,First_day_year),
       start_(Joint_return,First_day_year),
       last_day_year(Year,Last_day_year),
       end_(Joint_return,Last_day_year)
    ),
    \+ s152(Spouse,_,Year), % if the spouse is not the dependent of another taxpayer
    gross_income(Spouse,Year,0). % if the spouse has no gross income

s151_b(Taxpayer,Exemption_amount,Year) :- % An exemption of the exemption amount for the taxpayer
    s151_b_applies(Taxpayer,Year),
    s151_d(Taxpayer,_,Exemption_amount,Year).

s151_b(Taxpayer,Spouse,Exemption_amount,Year) :- % and an additional exemption of the exemption amount for the spouse
    s151_b_applies(Taxpayer,Spouse,Year),
    s151_d(Taxpayer,_,Exemption_amount,Year).

%(c) Additional exemption for dependents

%An exemption of the exemption amount for each individual who is a dependent (as defined in section 152) of the taxpayer for the taxable year.
s151_c_applies(Taxpayer,Individual,Year) :- % defining this auxiliary function allows to test whether "a deduction under this section is allowable" without going into an inf loop (c) -> (d) -> (c)...
    s152(Individual,Taxpayer,Year).

s151_c(Taxpayer,Individual,Exemption_amount,Year) :-
    s151_c_applies(Taxpayer,Individual,Year),
    s151_d(Taxpayer,_,Exemption_amount,Year).

%(d) Exemption amount

%For purposes of this section-
s151_d(Taxpayer,Individual,Exemption_amount,Year) :-
    (
        ( % either the exemption amount is disallowed or it's one of those years (both set the exemption to 0)
            s151_d_2(Taxpayer,Individual,_,Exemption_amount,Year);
            s151_d_5(Exemption_amount,Year)
        );
        ( % or it isn't
            \+ s151_d_2(Taxpayer,_,_,_,Year),
            \+ s151_d_5(_,Year),
            s151_d_1(Exemption_in),
            (
                s151_d_3(Taxpayer,Exemption_in,Exemption_amount,Year); % and Exemption_amount might have to be reduced
                (
                    \+ s151_d_3(Taxpayer,Exemption_in,Exemption_amount,Year),
                    Exemption_amount = Exemption_in
                )
            )
        )
    ).

%(1) In general

%Except as otherwise provided in this subsection, the term "exemption amount" means $2,000.
s151_d_1(Exemption_amount) :-
    Exemption_amount is 2000.

%(2) Exemption amount disallowed in case of certain dependents

%In the case of an individual with respect to whom a deduction under this section is allowable to another taxpayer for a taxable year beginning in the calendar year in which the individual's taxable year begins, the exemption amount applicable to such individual for such individual's taxable year shall be zero.
s151_d_2(Taxpayer,Individual,Another_taxpayer,Exemption_amount,Year) :-
    Taxpayer \== Another_taxpayer,
    (
        s151_b_applies(Another_taxpayer,Individual,Year);
        s151_c_applies(Another_taxpayer,Individual,Year)
    ),
    Exemption_amount is 0.

%(3) Phaseout
s151_d_3(Taxpayer,Exemption_amount_in,Exemption_amount_out,Year) :-
    s151_d_3_A(Taxpayer,_,_,_,Exemption_amount_in,Exemption_amount_out,Year).

%(A) In general

%In the case of any taxpayer whose adjusted gross income for the taxable year exceeds the applicable amount in effect under section 68(b), the exemption amount shall be reduced by the applicable percentage.
s151_d_3_A(Taxpayer,Gross_income,Applicable_amount,Applicable_percentage,Exemption_amount_in,Exemption_amount_out,Year) :-
    gross_income(Taxpayer,Year,Gross_income),
    !,
    s68_b(Taxpayer,Applicable_amount,Year),
    !,
    Gross_income>Applicable_amount,
    s151_d_3_B(Applicable_percentage,Taxpayer,Gross_income,Year,_),
    Reduction_amount is round( (Exemption_amount_in*Applicable_percentage) rdiv 100),
    Exemption_amount_out is max(Exemption_amount_in-Reduction_amount,0).

%(B) Applicable percentage

%For purposes of subparagraph (A), the term "applicable percentage" means 2 percentage points for each $2,500 (or fraction thereof) by which the taxpayer's adjusted gross income for the taxable year exceeds the applicable amount in effect under section 68(b). In the case of a married individual filing a separate return, the preceding sentence shall be applied by substituting "$1,250" for "$2,500". In no event shall the applicable percentage exceed 100 percent.
s151_d_3_B(Applicable_percentage,Taxpayer,Gross_income,Year,Applicable_amount) :-
    gross_income(Taxpayer,Year,Gross_income),
    s68_b(Taxpayer,Applicable_amount,Year),
    Difference is max(Gross_income-Applicable_amount,0),
    (
        ( % In the case of a married individual filing a separate return
            s7703(Taxpayer,Spouse,_,_,_,_,_,_,Year),
            \+ ( % if a joint return is not made by the taxpayer and his spouse
               joint_return_(Joint_return),
               agent_(Joint_return,Taxpayer),
               agent_(Joint_return,Spouse),
               first_day_year(Year,First_day_year),
               start_(Joint_return,First_day_year),
               last_day_year(Year,Last_day_year),
               end_(Joint_return,Last_day_year)
            )
        ) ->
        (
            Number is 2*ceil(Difference/1250)
        );
        (
            Number is 2*ceil(Difference/2500)
        )
    ),
    Applicable_percentage is min(Number,100).

%(5) Special rules for taxable years 2018 through 2025
%
%In the case of a taxable year beginning after December 31, 2017, and before January 1, 2026, the term "exemption amount" means zero.
s151_d_5(Exemption_amount,Year) :-
    between(2018,2025,Year),
    Exemption_amount is 0.
