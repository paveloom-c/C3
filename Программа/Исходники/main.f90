program main ! Программа, демонстрирующая использование модуля
             ! для спектрально-корреляционного анализа временных рядов
use SCATS, only: SCATS_API ! API модуля СКАВР
implicit none
     
     ! Определение экземпляра для использования API модуля СКАВР
     type( SCATS_API ) :: s

     ! Считывание параметров для генерации временного ряда
     call s%gen%params%read("Файлы/gen_params") 

     ! Генерация входных данных (во внутренний объект)
     call s%generate()

     ! Запись временного ряда в файл
     call s%input%write('Файлы/input')

     ! Визуализация входных данных
     call s%visualize%input('Файлы/input')

     ! Удаление линейного тренда
     call s%remove_linear_trend()

     ! Запись временного ряда в файл
     call s%result%write('Файлы/no_trend')

     ! Визуализация временного ряда после извлечения тренда
     call s%visualize%result('Файлы/no_trend', title="После извлечения тренда")

     ! Вычисление периодограммы
     call s%calculate_periodogram()

     ! Общее освобождение памяти
     call s%deallocate()

end program main