module gen_params_m ! Модуль, содержащий тип параметров для генерации временного 
                    ! ряда и процедуры, связанные с объектами этого типа
use prec_m, only : RP, & ! Точность вещественных чисел, используемых в программе
                 & IP, & ! Точность целых чисел, используемых в программе
                 & SP, & ! Точность целого числа статусной переменной
                 & UP, & ! Точность целого числа номера дескриптора файла
                 & LP    ! Число байт для хранения логической переменной
implicit none
     
     private
     public :: gen_params_type, & ! Тип, определяющий параметры
             & read_gen_params    ! Процедура для считывания параметров

     ! Тип, определяющий входные данные
     type gen_params_type

          private
          
          integer(IP) :: N ! Размер выборки

          real(RP) :: delta_t ! Шаг выборки
          real(RP) :: q ! Уровень значимости
          real(RP) :: alpha, beta ! Параметры линейного тренда
          
          integer(IP) :: r ! Число гармонических компонент

          real(RP), dimension(:), allocatable :: A ! Массив амплитуд
          real(RP), dimension(:), allocatable :: v ! Массив частот
          real(RP), dimension(:), allocatable :: phi ! Массив фазовых сдвигов

          real(RP) :: gamma ! Отношение «сигнал к шуму»

          contains

          procedure :: read => read_gen_params ! Процедура для считывания параметров для генерации временного ряда
          procedure :: deallocate => deallocate_gen_params ! Процедура для освобождения памяти из-под параметров
          
     end type gen_params_type

     interface
     
          ! Процедура для считывания параметров для генерации временного ряда
          module impure subroutine read_gen_params(gen_params, file)
          implicit none
          
               class ( gen_params_type ), intent(inout) :: gen_params ! Параметры
               character(*), intent(in) :: file ! Имя файла для считывания
          
          end subroutine read_gen_params

          ! Процедура для вывода ошибок для других процедур, связанных с параметрами для генерации временного ряда
          module impure subroutine log_gen_params_error(error_code, file)
          implicit none
               
               character(*), intent(in) :: error_code     ! Код ошибки
               character(*), intent(in), optional :: file ! Имя файла для считывания

          end subroutine log_gen_params_error

          ! Процедура для освобождения памяти из-под параметров
          module impure subroutine deallocate_gen_params(gen_params)
          implicit none
               
               class ( gen_params_type ), intent(inout) :: gen_params ! Параметры

          end subroutine deallocate_gen_params
     
     end interface
     
end module gen_params_m
