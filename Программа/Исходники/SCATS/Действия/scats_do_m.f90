module scats_do_m ! Модуль, содержащий процедуры для выполнения
                  ! вычислительных операций над данными
use scats_input_m, only : input_type ! Тип, определяющий входные данные
use scats_result_m, only : result_type ! Тип, определяющий результат
use scats_do_trend_m, only : scats_do_trend_remove_linear_trend ! Процедура для удаления линейного тренда из входных данных
implicit none
     
     private
     public :: scats_do_trend_remove_linear_trend ! Процедура для удаления линейного тренда из входных данных
     
end module scats_do_m