# Mellionare

Первое практическое задание для курса "Архитектуры и шаблоны проектирования на Swift"

Базовые паттерны, часть 1. Delegate, Singleton, Memento

Реализована базовая верстка и начальная логика игры "Кто хочет стать миллионером"
Логику использования подсказок написал, пока не стал использовать в верстке - по дальнейшим заданиям будет реализовано.

Вопросы:
Запутался по архитектуре - какой класс должен решать задачи - правильный ли ответ, использования подсказок, завершать ли игру? (Game? Session? GameViewController?) Пока решил, пусть сессия контролирует.
Или разумнее Game сделать делегатом для сессии?
