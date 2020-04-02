%§63. Taxable income defined
s63(Taxpayer,Year,Taxable_income) :-
    (
		s63_b(Taxpayer,Year,Taxable_income_tmp);
		(
			\+ s63_b(Taxpayer,Year,_),
			s63_a(Taxpayer,Year,Taxable_income_tmp)
		)
	),
	Taxable_income is max(Taxable_income_tmp,0).

%(a) In general

%Except as provided in subsection (b), for purposes of this subtitle, the term "taxable income" means gross income minus the deductions allowed by this chapter (other than the standard deduction).
s63_a(Taxpayer,Year,Taxable_income) :-
    gross_income(Taxpayer,Year,Gross_income),
	s63_d(Taxpayer,_,Total_deduction,Year),
	s68(Taxpayer,Total_deduction,Total_deduction_reduced,Year),
	s151(Taxpayer,Exemption_151,_,_,Year),
	Total_deduction_allowed is Total_deduction_reduced + Exemption_151,
    Taxable_income_tmp is Gross_income - Total_deduction_allowed,
	Taxable_income is max(Taxable_income_tmp,0).

%(b) Individuals who do not itemize their deductions

%In the case of an individual who does not elect to itemize his deductions for the taxable year, for purposes of this subtitle, the term "taxable income" means adjusted gross income, minus-
s63_b(Individual,Year,Taxable_income) :-
    \+ s63_d(Individual,_,_,Year),
    gross_income(Individual,Year,Gross_income),
    s63_b_1(Individual,Year,Amount1),
    s63_b_2(Individual,Year,Amount2),
    Taxable_income_tmp is Gross_income - Amount1 - Amount2,
	Taxable_income is max(Taxable_income_tmp,0).

%(1) the standard deduction, and
s63_b_1(Taxpayer,Year,Standard_deduction) :-
    s63_c(Taxpayer,Year,Standard_deduction).

%(2) the deduction for personal exemptions provided in section 151.
s63_b_2(Taxpayer,Year,Deduction) :-
    s151(Taxpayer,Deduction,_,_,Year).

%(c) Standard deduction

%For purposes of this subtitle-
s63_c(Taxpayer,Year,Standard_deduction) :- % exceptions are already dealt with earlier
    s63_c_1(Taxpayer,Year,Standard_deduction).

%(1) In general

%Except as otherwise provided in this subsection, the term "standard deduction" means the sum of-
s63_c_1(Taxpayer,Year,Standard_deduction) :-
    (
        s63_c_6(Taxpayer,_,_,Year,Standard_deduction);
        (
           \+ s63_c_6(Taxpayer,_,_,Year,_),
            s63_c_1_A(Taxpayer,Year,Basic_deduction),
            s63_c_1_B(Taxpayer,Year,Additional_deduction),
            Standard_deduction is Basic_deduction+Additional_deduction
        )
    ).

%(A) the basic standard deduction, and
s63_c_1_A(Taxpayer,Year,Basic_standard_deduction) :-
    s63_c_2(Taxpayer,Year,Basic_amount),
    (
        (
            s63_c_5(Taxpayer,_,Year,Max_amount),
            Basic_standard_deduction is min(Basic_amount,Max_amount)
        );
        (
            \+ s63_c_5(Taxpayer,_,Year,_),
            Basic_standard_deduction is Basic_amount
        )
    ).

%(B) the additional standard deduction.
s63_c_1_B(Taxpayer,Year,Additional_standard_deduction) :-
    s63_c_3(Taxpayer,Additional_standard_deduction,Year).

%(2) Basic standard deduction

%For purposes of paragraph (1), the basic standard deduction is-
s63_c_2(Taxpayer,Year,Basic_standard_deduction) :-
    (
        s63_c_2_A(Taxpayer,Year,Multiplier),
        \+ s63_c_2_B(Taxpayer,Year,_),
        s63_c_2_C(Year,Default_amount),
        Basic_standard_deduction is Multiplier*Default_amount
    );
    (
        \+ s63_c_2_A(Taxpayer,Year,_),
        s63_c_2_B(Taxpayer,Year,Basic_standard_deduction)
    );
    (
        \+ s63_c_2_A(Taxpayer,Year,_),
        \+ s63_c_2_B(Taxpayer,Year,_),
        s63_c_2_C(Year,Basic_standard_deduction)
    ).

%(A) 200 percent of the dollar amount in effect under subparagraph (C) for the taxable year in the case of-
s63_c_2_A(Taxpayer,Year,Multiplier) :-
    (
        s63_c_2_A_i(Taxpayer,Year);
        s63_c_2_A_ii(Taxpayer,Year)
    ),
    Multiplier is 2.

%(i) a joint return, or
s63_c_2_A_i(Taxpayer,Year) :-
    s7703(Taxpayer,Spouse,_,_,_,_,_,_,Year),
    joint_return_(Joint_return),
    agent_(Joint_return,Taxpayer),
    agent_(Joint_return,Spouse),
    first_day_year(Year,First_day),
    start_(Joint_return,First_day),
    last_day_year(Year,Last_day),
    end_(Joint_return,Last_day).

%(ii) a surviving spouse (as defined in section 2(a)),
s63_c_2_A_ii(Taxpayer,Year) :-
    s2_a(Taxpayer,_,_,_,Year).

%(B) $4,400 in the case of a head of household (as defined in section 2(b)), or
s63_c_2_B(Taxpayer,Year,Basic_standard_deduction) :-
    s2_b(Taxpayer,_,_,Year),
    (
        s63_c_7_i(Year,Basic_standard_deduction);
        (
            \+ s63_c_7_i(Year,_),
            Basic_standard_deduction is 4400
        )
    ).

%(C) $3,000 in any other case.
s63_c_2_C(Year,Basic_standard_deduction) :-
    s63_c_7_ii(Year,Basic_standard_deduction);
    (
        \+ s63_c_7_ii(Year,_),
        Basic_standard_deduction is 3000
    ).

%(3) Additional standard deduction for aged and blind

%For purposes of paragraph (1), the additional standard deduction is the sum of each additional amount to which the taxpayer is entitled under subsection (f).
s63_c_3(Taxpayer,Additional_standard_deduction,Year) :-
    s63_f(Taxpayer,Additional_standard_deduction,Year).

%(5) Limitation on basic standard deduction in the case of certain dependents

%In the case of an individual with respect to whom a deduction under section 151 is allowable to another taxpayer for a taxable year beginning in the calendar year in which the individual's taxable year begins, the basic standard deduction applicable to such individual for such individual's taxable year shall not exceed the greater of-

%(A) $500, or

%(B) the sum of $250 and such individual's earned income.
s63_c_5(Individual,Another_taxpayer,Year,Basic_standard_deduction) :-
    (
        s151_b_applies(Another_taxpayer,Individual,Year);
        s151_c_applies(Another_taxpayer,Individual,Year)
    ),
    Amount1 is 500,
    gross_income(Individual,Year,Gross_income),
    Amount2 is 250+Gross_income,
    Basic_standard_deduction is max(Amount1,Amount2).

%(6) Certain individuals, etc., not eligible for standard deduction
s63_c_6(Individual,Spouse,Deduction_itemization,Year,Standard_deduction) :-
    (
        s63_c_6_A(Individual,Spouse,Deduction_itemization,Year);
        s63_c_6_B(Individual,Year);
        s63_c_6_D(Individual,Year)
    ),
    Standard_deduction is 0.

%In the case of-

%(A) a married individual filing a separate return where either spouse itemizes deductions,
s63_c_6_A(Individual,Spouse,Deduction_itemization,Year) :-
   s7703(Individual,Spouse,_,_,_,_,_,_,Year), 
   first_day_year(Year,First_day_year),
   last_day_year(Year,Last_day_year),
   \+ (
       joint_return_(Joint_return),
       agent_(Joint_return,Individual),
       agent_(Joint_return,Spouse),
       start_(Joint_return,First_day_year),
       end_(Joint_return,Last_day_year)
   ),
   deduction_(Deduction_itemization),
   (
       agent_(Deduction_itemization,Individual);
       agent_(Deduction_itemization,Spouse)
   ),
   start_(Deduction_itemization,Start),
   is_before(First_day_year,Start),
   is_before(Start,Last_day_year).

%(B) a nonresident alien individual, or
s63_c_6_B(Individual,Year) :-
    nonresident_alien_(Taxpayer_is_nra),
    agent_(Taxpayer_is_nra,Individual),
    first_day_year(Year,First_day_year),
    last_day_year(Year,Last_day_year),
    (
        (
            \+ start_(Taxpayer_is_nra,_)
        );
        (
            start_(Taxpayer_is_nra,Start_nra),
            is_before(Start_nra,Last_day_year)
        )
    ),
    (
        (
            \+ end_(Taxpayer_is_nra,_)
        );
        (
            end_(Taxpayer_is_nra,End_nra),
            is_before(First_day_year,End_nra)
        )
    ).

%(D) an estate or trust, common trust fund, or partnership,
s63_c_6_D(Taxpayer,Year) :-
    business_trust_(Taxpayer_is_trust),
    agent_(Taxpayer_is_trust,Taxpayer),
    first_day_year(Year,First_day_year),
    last_day_year(Year,Last_day_year),
    (
        (
            \+ start_(Taxpayer_is_trust,_)
        );
        (
            start_(Taxpayer_is_trust,Start_trust),
            is_before(Start_trust,Last_day_year)
        )
    ),
    (
        (
            \+ end_(Taxpayer_is_trust,_)
        );
        (
            end_(Taxpayer_is_trust,End_trust),
            is_before(First_day_year,End_trust)
        )
    ).

%the standard deduction shall be zero.

%(7) Special rules for taxable years 2018 through 2025

%In the case of a taxable year beginning after December 31, 2017, and before January 1, 2026-

%Paragraph (2) shall be applied-

%(i) by substituting "$18,000" for "$4,400" in subparagraph (B), and
s63_c_7_i(Year,Amount) :-
    Year>2017,
    Year<2026,
    Amount is 18000.

%(ii) by substituting "$12,000" for "$3,000" in subparagraph (C).
s63_c_7_ii(Year,Amount) :-
    Year>2017,
    Year<2026,
    Amount is 12000.

%(d) Itemized deductions

%For purposes of this subtitle, the term "itemized deductions" means the deductions allowable under this chapter other than-
s63_d(Taxpayer,Amounts,Itemized_deductions,Year) :-
	first_day_year(Year,First),
	last_day_year(Year,Last),
	findall(
	    Amount,
		(
	        deduction_(Deduction),
	        agent_(Deduction,Taxpayer),
	        amount_(Deduction,Amount),
			start_(Deduction,Start),
			is_before(First,Start),
			is_before(Start,Last)
		),
		Amounts
	),
	length(Amounts,L),
	L>0,
	sum_list(Amounts,Itemized_deductions).

%(1) the deductions allowable in arriving at adjusted gross income, and

%(2) the deduction for personal exemptions provided by section 151.
s63_d_2(Taxpayer,Individuals,Personal_exemptions,Year) :-
    s151(Taxpayer,_,Individuals,Personal_exemptions,Year).

%(f) Aged or blind additional amounts
s63_f(Taxpayer,Additional_amounts,Year) :-
    s63_f_1(Taxpayer,Year,Counts_aged),
    s63_f_2(Taxpayer,Year,Counts_blind),
    (
        s63_f_3(Taxpayer,Year,Amount);
        (
            \+ s63_f_3(Taxpayer,Year,_),
            Amount is 600
        )
    ),
    Additional_amounts is (Counts_blind+Counts_aged)*Amount.

%(1) Additional amounts for the aged

%The taxpayer shall be entitled to an additional amount of $600-
s63_f_1(Taxpayer,Year,Counts) :- % count deductions
    (s63_f_1_A(Taxpayer,Year) -> Count1 is 1; Count1 is 0),
    (s63_f_1_B(Taxpayer,Year) -> Count2 is 1; Count2 is 0),
    Counts is Count1+Count2.

%(A) for himself if he has attained age 65 before the close of his taxable year, and
s63_f_1_A(Taxpayer,Year) :-
    birth_(Taxpayer_birth),
    agent_(Taxpayer_birth,Taxpayer),
    start_(Taxpayer_birth,Day_of_birth),
    last_day_year(Year,Last_day_year),
    duration(Day_of_birth,Last_day_year,Time_since_birth),
    Year65 is Year+65,
    last_day_year(Year65,Last_day_year65),
    duration(Last_day_year,Last_day_year65,Sixtyfive_years),
    Time_since_birth>=Sixtyfive_years.

%(B) for the spouse of the taxpayer if the spouse has attained age 65 before the close of the taxable year and an additional exemption is allowable to the taxpayer for such spouse under section 151(b).
s63_f_1_B(Taxpayer,Year) :-
    s7703(Taxpayer,Spouse,_,_,_,_,_,_,Year),
    birth_(Spouse_birth),
    agent_(Spouse_birth,Spouse),
    start_(Spouse_birth,Day_of_birth),
    last_day_year(Year,Last_day_year),
    duration(Day_of_birth,Last_day_year,Time_since_birth),
    Year65 is Year+65,
    last_day_year(Year65,Last_day_year65),
    duration(Last_day_year,Last_day_year65,Sixtyfive_years),
    Time_since_birth>=Sixtyfive_years,
    s151_b_applies(Taxpayer,Spouse,Year).

%(2) Additional amount for blind

%The taxpayer shall be entitled to an additional amount of $600-
s63_f_2(Taxpayer,Year,Counts) :-
    (s63_f_2_A(Taxpayer,Year) -> Count1 is 1; Count1 is 0),
    (s63_f_2_B(Taxpayer,Year) -> Count2 is 600; Count2 is 0),
    Counts is Count1+Count2.

%(A) for himself if he is blind at the close of the taxable year, and
s63_f_2_A(Taxpayer,Year) :-
    blindness_(Taxpayer_is_blind),
    agent_(Taxpayer_is_blind,Taxpayer),
    start_(Taxpayer_is_blind,Start_time),
    last_day_year(Year,Last_day_year),
    is_before(Start_time,Last_day_year).

%(B) for the spouse of the taxpayer if the spouse is blind as of the close of the taxable year and an additional exemption is allowable to the taxpayer for such spouse under section 151(b).
s63_f_2_B(Taxpayer,Year) :-
    s7703(Taxpayer,Spouse,_,_,_,_,_,_,Year),
    blindness_(Spouse_is_blind),
    agent_(Spouse_is_blind,Spouse),
    start_(Spouse_is_blind,Start_time),
    last_day_year(Year,Last_day_year),
    is_before(Start_time,Last_day_year),
    s151_b_applies(Taxpayer,Spouse,Year).

%For purposes of subparagraph (B), if the spouse dies during the taxable year the determination of whether such spouse is blind shall be made as of the time of such death.

%(3) Higher amount for certain unmarried individuals

%In the case of an individual who is not married and is not a surviving spouse, paragraphs (1) and (2) shall be applied by substituting "$750" for "$600".
s63_f_3(Individual,Year,Amount) :-
    \+ s7703(Individual,_,_,_,_,_,_,_,Year),
    \+ s2_a(Individual,_,_,_,Year),
    Amount is 750.

%(g) Marital status

%For purposes of this section, marital status shall be determined under section 7703.
