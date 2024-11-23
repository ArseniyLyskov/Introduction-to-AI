% Данная экспертная система предназначена для определения породы кошки по различным признакам.
% Реализована стратегия Forward Chaining с подсистемой вывода и опроса пользователя.

% БАЗА ЗНАНИЙ

% Основные факты о кошках
fact(cat).
fact(whiskers).

% Признаки кошек, которые могут быть использованы для вывода породы
fact(short_hair).
fact(long_hair).
fact(blue_eyes).
fact(flat_face).
fact(big_size).
fact(unusual_ears).
fact(active).
fact(hairless).
fact(calm).
fact(small_size).
fact(cold_tolerance).
fact(weight).
fact(origin).

% Правила вывода для пород кошек
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

% Правила для определения промежуточных фактов
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
    format('Does the cat have the following characteristic: ~w? (yes/no)~n', [Question]),
    read(Response),
    ( Response == yes -> assert(fact(Question)) ;
      Response == no -> true ).

% Подсистема опроса для интерактивного режима
ask_user :- 
    ask(short_hair); 
    ask(long_hair);
    ask(blue_eyes);
    ask(flat_face);
    ask(big_size);
    ask(unusual_ears);
    ask(active);
    ask(hairless);
    ask(calm);
    ask(small_size);
    ask(cold_tolerance);
    ask(weight);
    ask(origin),
    fail.
ask_user :- 
    format('Inference process complete.~n').

% Предикат вывода результатов
reasoning :- 
    rule(Result), 
    \+ fact(Result), 
    assert(fact(Result)), 
    format('Inferred that ~w.~n', [Result]), 
    fail.
reasoning :- 
    format('Done. Inference process complete.~n').

% Запуск программы
demo :-
    write('Welcome to the cat breed expert system!'), nl,
    ask_user,               % Опрос пользователя для всех необходимых фактов
    reasoning.              % Вывод результата на основе сделанных выводов
