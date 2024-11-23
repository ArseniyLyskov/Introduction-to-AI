% Данная экспертная система предназначена для определения породы кошки по различным признакам.
% Реализована стратегия Forward Chaining с подсистемой вывода и опроса пользователя.

% БАЗА ЗНАНИЙ

% Основные факты о кошках
fact(cat).
fact(whiskers).

% Правила вывода
rule(siamese) :-
    fact(cat),
    fact(short_hair),
    fact(blue_eyes).

rule(persian) :-
    fact(cat),
    fact(long_hair),
    fact(flat_face).

rule(maine_coon) :-
    fact(cat),
    fact(long_hair),
    fact(big_size),
    fact(unusual_ears).

rule(bengal) :-
    fact(cat),
    fact(short_hair),
    fact(active).

rule(sphynx) :-
    fact(cat),
    fact(hairless).

rule(ragdoll) :-
    fact(cat),
    fact(long_hair),
    fact(blue_eyes).

rule(siberian) :-
    fact(cat),
    fact(long_hair),
    fact(cold_tolerance).

rule(british_shorthair) :-
    fact(cat),
    fact(short_hair),
    fact(calm).

rule(scottish_fold) :-
    fact(cat),
    fact(short_hair),
    fact(unusual_ears).

rule(devon_rex) :-
    fact(cat),
    fact(short_hair),
    fact(small_size).

% Промежуточные выводы
rule(hairless) :-
    fact(hair_length),
    fact(hair_length = none).

rule(short_hair) :-
    fact(hair_length),
    fact(hair_length = short).

rule(long_hair) :-
    fact(hair_length),
    fact(hair_length = long).

rule(small_size) :-
    fact(weight),
    fact(weight =< 6).

rule(big_size) :-
    fact(weight),
    fact(weight > 6).

rule(cold_tolerance) :-
    fact(origin),
    fact(origin = cold_climate).

% Вопросы к пользователю
ask(Question) :-
    format('Is it true that ~w? Please answer \'yes\', \'no\' or \'why\'.~n', [Question]),
    read(Response),
    (Response == yes -> assert(fact(Question)); Response == why -> explain(Question), ask(Question); Response == no -> true).

% Объяснение вывода
explain(Goal) :-
    rule(Goal),
    format('To infer ~w, using rule: ~w.~n', [Goal, Goal]).

% Предикат demo для демонстрации работы
:- dynamic fact/1.

demo :-
    assert(fact(hair_length(short))),
    assert(fact(blue_eyes)),
    assert(fact(vocal)),
    assert(fact(docile)),
    reasoning.

reasoning :-
    rule(Result),
    \+ fact(Result),
    assert(fact(Result)),
    format('Inferred that ~w.~n', [Result]),
    fail.
reasoning :-
    format('Done.~n').

% Подсистема опроса для интерактивного режима
ask_user :-
    rule(Goal),
    \+ fact(Goal),
    ask(Goal),
    fail.
ask_user :-
    format('Inference complete.~n').
