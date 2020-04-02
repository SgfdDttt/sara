%§1. Tax imposed
s1(Individual,Year,Taxable_income,Tax) :-
    s1_a(Individual,Year,Taxable_income,Tax);
    s1_b(Individual,Year,Taxable_income,Tax);
    s1_c(Individual,Year,Taxable_income,Tax);
    s1_d(Individual,_,Year,Taxable_income,Tax).

%(a) Married individuals filing joint returns and surviving spouses
s1_a(Individual,Year,Taxable_income,Tax) :-
    (
        s1_a_1(Individual,_,_,Year,Taxable_income,Tax);
        s1_a_2(Individual,Year,Taxable_income,Tax)
    ).

%There is hereby imposed on the taxable income of-

%(1) every married individual (as defined in section 7703) who makes a single return jointly with his spouse, and
s1_a_1(Individual,Single_return_jointly,Spouse,Year,Taxable_income,Tax) :-
    s7703(Individual,Spouse,_,_,_,_,_,_,Year),
    joint_return_(Single_return_jointly),
    agent_(Single_return_jointly,Individual),
    agent_(Single_return_jointly,Spouse),
    first_day_year(Year,First_day),
    last_day_year(Year,Last_day),
    start_(Single_return_jointly,First_day),
    end_(Single_return_jointly,Last_day),
    \+ ( % nonresident aliens can't file jointly
        nonresident_alien_(someone_is_nra),
        (
            agent_(someone_is_nra,Individual);
            agent_(someone_is_nra,Spouse)
        ),
        (
            (
                \+ start_(someone_is_nra,_),
                Start_time=First_day
            );
            start_(someone_is_nra,Start_time)
        ),
        (
            (
                \+ end_(someone_is_nra,_),
                End_time=Last_day
            );
            end_(someone_is_nra,End_time)
        ),
        is_before(Start_time,Last_day),
        is_before(First_day,End_time)
    ),
    s63(Individual,Year,Taxable_income),
    s1_a_tax(Taxable_income,Tax).

%(2) every surviving spouse (as defined in section 2(a)),
s1_a_2(Individual,Year,Taxable_income,Tax) :-
    s2_a(Individual,_,_,_,Year),
    s63(Individual,Year,Taxable_income),
    s1_a_tax(Taxable_income,Tax).

%Such tax shall be:
s1_a_tax(Taxable_income,Tax) :-
    s1_a_i(Taxable_income,Tax);
    s1_a_ii(Taxable_income,Tax);
    s1_a_iii(Taxable_income,Tax);
    s1_a_iv(Taxable_income,Tax);
    s1_a_v(Taxable_income,Tax).

%(i) 15% of taxable income if the taxable income is not over $36,900;
s1_a_i(Taxable_income,Tax) :-
    Taxable_income =< 36900,
    Tax is round(Taxable_income*0.15).
%(ii) $5,535, plus 28% of the excess over $36,900 if the taxable income is over $36,900 but not over $89,150;
s1_a_ii(Taxable_income,Tax) :-
    Taxable_income =< 89150,
    36900 < Taxable_income,
    Tax is round(5535+(Taxable_income-36900)*0.28).
%(iii) $20,165, plus 31% of the excess over $89,150 if the taxable income is over $89,150 but not over $140,000;
s1_a_iii(Taxable_income,Tax) :-
    Taxable_income =< 140000,
    89150 < Taxable_income,
    Tax is round(20165+(Taxable_income-89150)*0.31).
%(iv) $35,928.50, plus 36% of the excess over $140,000 if the taxable income is over $140,000 but not over $250,000;
s1_a_iv(Taxable_income,Tax) :-
    Taxable_income =< 250000,
    140000 < Taxable_income,
    Tax is round(35928.50+(Taxable_income-140000)*0.36).
%(v) $75,528.50, plus 39.6% of the excess over $250,000 if the taxable income is over $250,000.
s1_a_v(Taxable_income,Tax) :-
    250000 < Taxable_income,
    Tax is round(75528.50+(Taxable_income-250000)*0.396).

%(b) Heads of households

%There is hereby imposed on the taxable income of every head of a household (as defined in section 2(b)) a tax determined in accordance with the following:
s1_b(Head_household,Year,Taxable_income,Tax) :-
    s2_b(Head_household,_,_,Year),
    s63(Head_household,Year,Taxable_income),
    (
        s1_b_i(Taxable_income,Tax);
        s1_b_ii(Taxable_income,Tax);
        s1_b_iii(Taxable_income,Tax);
        s1_b_iv(Taxable_income,Tax);
        s1_b_v(Taxable_income,Tax)
    ).

%(i) 15% of taxable income if the taxable income is not over $29,600;
s1_b_i(Taxable_income,Tax) :-
    Taxable_income =< 29600,
    Tax is round(Taxable_income*0.15).
%(ii) $4,440, plus 28% of the excess over $29,600 if the taxable income is over $29,600 but not over $76,400;
s1_b_ii(Taxable_income,Tax) :-
    Taxable_income =< 76400,
    29600 < Taxable_income,
    Tax is round(4440+(Taxable_income-29600)*0.28).
%(iii) $17,544, plus 31% of the excess over $76,400 if the taxable income is over $76,400 but not over $127,500;
s1_b_iii(Taxable_income,Tax) :-
    Taxable_income =< 127500,
    76400 < Taxable_income,
    Tax is round(17544+(Taxable_income-76400)*0.31).
%(iv) $33,385, plus 36% of the excess over $127,500 if the taxable income is over $127,500 but not over $250,000;
s1_b_iv(Taxable_income,Tax) :-
    Taxable_income =< 250000,
    127500 < Taxable_income,
    Tax is round(33385+(Taxable_income-127500)*0.36).
%(v) $77,485, plus 39.6% of the excess over $250,000 if the taxable income is over $250,000.
s1_b_v(Taxable_income,Tax) :-
    250000 < Taxable_income,
    Tax is round(77485+(Taxable_income-250000)*0.396).

%(c) Unmarried individuals (other than surviving spouses and heads of households)

%There is hereby imposed on the taxable income of every individual (other than a surviving spouse as defined in section 2(a) or the head of a household as defined in section 2(b)) who is not a married individual (as defined in section 7703) a tax determined in accordance with the following:
s1_c(Individual,Year,Taxable_income,Tax) :-
    \+ s2_a(Individual,_,_,_,Year),
    \+ s2_b(Individual,_,_,Year),
    \+ s7703(Individual,_,_,_,_,_,_,_,Year),
    s63(Individual,Year,Taxable_income),
    (
        s1_c_i(Taxable_income,Tax);
        s1_c_ii(Taxable_income,Tax);
        s1_c_iii(Taxable_income,Tax);
        s1_c_iv(Taxable_income,Tax);
        s1_c_v(Taxable_income,Tax)
    ).

%(i) 15% of taxable income if the taxable income is not over $22,100;
s1_c_i(Taxable_income,Tax) :-
    Taxable_income =< 22100,
    Tax is round(Taxable_income*0.15).
%(ii) $3,315, plus 28% of the excess over $22,100 if the taxable income is over $22,100 but not over $53,500;
s1_c_ii(Taxable_income,Tax) :-
    Taxable_income =< 53500,
    22100 < Taxable_income,
    Tax is round(3315+(Taxable_income-22100)*0.28).
%(iii) $12,107, plus 31% of the excess over $53,500 if the taxable income is over $53,500 but not over $115,000;
s1_c_iii(Taxable_income,Tax) :-
    Taxable_income =< 115000,
    53500 < Taxable_income,
    Tax is round(12107+(Taxable_income-53500)*0.31).
%(iv) $31,172, plus 36% of the excess over $115,000 if the taxable income is over $115,000 but not over $250,000;
s1_c_iv(Taxable_income,Tax) :-
    Taxable_income =< 250000,
    115000 < Taxable_income,
    Tax is round(31172+(Taxable_income-115000)*0.36).
%(v) $79,772, plus 39.6% of the excess over $250,000 if the taxable income is over $250,000.
s1_c_v(Taxable_income,Tax) :-
    250000 < Taxable_income,
    Tax is round(79772+(Taxable_income-250000)*0.396).

%(d) Married individuals filing separate returns

%There is hereby imposed on the taxable income of every married individual (as defined in section 7703) who does not make a single return jointly with his spouse, a tax determined in accordance with the following:
s1_d(Individual,Spouse,Year,Taxable_income,Tax) :-
    s7703(Individual,Spouse,_,_,_,_,_,_,Year),
    \+ (
        joint_return_(Joint_return),
        agent_(Joint_return,Individual),
        agent_(Joint_return,Spouse),
        first_day_year(Year,First_day),
        last_day_year(Year,Last_day),
        start_(Joint_return,First_day),
        end_(Joint_return,Last_day)
    ),
    s63(Individual,Year,Taxable_income),
    (
        s1_d_i(Taxable_income,Tax);
        s1_d_ii(Taxable_income,Tax);
        s1_d_iii(Taxable_income,Tax);
        s1_d_iv(Taxable_income,Tax);
        s1_d_v(Taxable_income,Tax)
    ).

%(i) 15% of taxable income if the taxable income is not over $18,450;
s1_d_i(Taxable_income,Tax) :-
    Taxable_income =< 18450,
    Tax is round(Taxable_income*0.15).
%(ii) $2,767.50, plus 28% of the excess over $18,450 if the taxable income is over $18,450 but not over $44,575;
s1_d_ii(Taxable_income,Tax) :-
    Taxable_income =< 44575,
    18450 < Taxable_income,
    Tax is round(2767.50+(Taxable_income-18450)*0.28).
%(iii) $10,082.50, plus 31% of the excess over $44,575 if the taxable income is over $44,575 but not over $70,000;
s1_d_iii(Taxable_income,Tax) :-
    Taxable_income =< 70000,
    44575 < Taxable_income,
    Tax is round(10082.50+(Taxable_income-44575)*0.31).
%(iv) $17,964.25, plus 36% of the excess over $70,000 if the taxable income is over $70,000 but not over $125,000;
s1_d_iv(Taxable_income,Tax) :-
    Taxable_income =< 125000,
    70000 < Taxable_income,
    Tax is round(17964.25+(Taxable_income-70000)*0.36).
%(v) $37,764.25, plus 39.6% of the excess over $125,000 if the taxable income is over $125,000
s1_d_v(Taxable_income,Tax) :-
    125000 < Taxable_income,
    Tax is round(37764.25+(Taxable_income-125000)*0.396).
