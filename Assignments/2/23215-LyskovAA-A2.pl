:- use_module('C:/Users/lysko/MyProlog/wnload/prolog/wn').

% Основной предикат для поиска связей между словами
related_words(W1/PoS1/Sense1/Syn1, W2/PoS2/Sense2/Syn2, MaxDist, Connection) :-
    wn_s(Syn1, _, W1, PoS1, Sense1, _),
    wn_s(Syn2, _, W2, PoS2, Sense2, _),
    find_connections(Syn1, W1, PoS1, Sense1, Syn2, W2, PoS2, Sense2, MaxDist, [], Path),
    reverse(Path, Connection).  % Переворачиваем путь, чтобы он был в нужном порядке

% Поиск связей между синонимами, гиперонимами и т.д.
find_connections(Syn1, W1, PoS1, Sense1, Syn2, W2, PoS2, Sense2, 0, _, []) :- 
    !.  % Прекращаем поиск при глубине 0

find_connections(Syn1, W1, PoS1, Sense1, Syn2, W2, PoS2, Sense2, MaxDist, Visited, [r(W1/PoS1/Sense1, Rel, WNext/PoSNext/SenseNext) | Rest]) :-
    MaxDist > 0,
    ( wn_hyp(Syn1, SynNext) -> Rel = hyp ;
      wn_mm(Syn1, SynNext) -> Rel = mm ;
      wn_mp(Syn1, SynNext) -> Rel = mp ),
    \+ member(SynNext, Visited),  % Проверка на цикличность
    wn_s(SynNext, _, WNext, PoSNext, SenseNext, _),
    NewVisited = [SynNext | Visited],

    % Если нашли конечный синсет, добавляем последний шаг
    ( SynNext = Syn2 -> 
        Rest = [r(WNext/PoSNext/SenseNext, Rel, W2/PoS2/Sense2)] 
    ; 
        % Иначе продолжаем искать
        NewDist is MaxDist - 1,
        find_connections(SynNext, WNext, PoSNext, SenseNext, Syn2, W2, PoS2, Sense2, NewDist, NewVisited, Rest)
    ).

% Завершающая цепочка для совпавших синсетов
find_connections(Syn1, W1, PoS1, Sense1, Syn2, W2, PoS2, Sense2, MaxDist, Visited, [r(W1/PoS1/Sense1, hyp, W2/PoS2/Sense2) | Rest]) :- 
    Syn1 = Syn2,  % Если начальный и конечный синсет одинаковы, завершаем поиск
    Rest = [].    % Заканчиваем цепочку
