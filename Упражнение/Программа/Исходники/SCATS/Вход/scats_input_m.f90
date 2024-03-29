module scats_input_m ! Модуль, содержащий тип, определяющий
                     ! входные данные и связанные с ними процедуры
use prec_m, only : RP, & ! Точность вещественных чисел, используемых в программе
                 & SP, & ! Точность целого числа статусной переменной
                 & RF, & ! Формат вывода вещественных чисел
                 & JP, & ! Точность целого числа счетчика и индекса
                 & FP, & ! Число байт для хранения вспомогательной строки
                 & UP ! Точность целого числа номера дескриптора файла
implicit none

     private
     public :: input_type ! Тип, определяющий входные данные

     ! Тип, определяющий входные данные
     type input_type

          real(RP) :: delta_t ! Шаг выборки
          real(RP) :: q ! Уровень значимости

          real(RP), allocatable, dimension(:) :: t ! Массив времени
          real(RP), allocatable, dimension(:) :: x ! Массив значений

          contains

          ! Процедура освобождения памяти из-под входных данных
          procedure :: deallocate => scats_input_deallocate

          ! Процедура для считывания входных данных из файла
          procedure :: read => scats_input_read

          ! Процедура для записи входных данных в файл
          procedure :: write => scats_input_write_to_file

     end type input_type

     interface

          ! Процедура освобождения памяти из-под входных данных
          module impure subroutine scats_input_deallocate(input)
          implicit none

               class( input_type ), intent(inout) :: input ! Входные данные

          end subroutine scats_input_deallocate

          ! Процедура для вывода ошибок (входные данные)
          module impure subroutine scats_input_log_error(error_code, file, call_stat)
          implicit none

               character(*), intent(in) :: error_code ! Код ошибки
               character(*), intent(in), optional :: file ! Имя файла для записи

               logical, intent(inout), optional :: call_stat ! Логическая переменная процедуры

          end subroutine scats_input_log_error

          ! Процедура для считывания входных данных
          module impure subroutine scats_input_read(input, file, call_stat)
          implicit none

               class( input_type ), intent(inout) :: input ! Входные данные
               character(*), intent(in) :: file ! Файл для записи

               logical, intent(inout) :: call_stat ! Логическая переменная процедуры

          end subroutine scats_input_read

          ! Процедура для записи входных данных в файл
          module impure subroutine scats_input_write_to_file(input, file, call_stat)
          implicit none

               class( input_type ), intent(inout) :: input ! Входные данные
               character(*), intent(in) :: file ! Файл для записи

               logical, intent(inout) :: call_stat ! Логическая переменная процедуры

          end subroutine scats_input_write_to_file

     end interface

end module scats_input_m