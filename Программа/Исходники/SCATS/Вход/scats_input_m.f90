module scats_input_m ! Модуль, содержащий тип, определяющий
                     ! входные данные и связанные с ними процедуры
use prec_m, only : RP, & ! Точность вещественных чисел, используемых в программе
                 & IP, & ! Точность целых чисел, используемых в программе
                 & SP, & ! Точность целого числа статусной переменной
                 & RF, & ! Формат вывода вещественных чисел
                 & JP, & ! Точность целого числа счетчика и индекса
                 & FP, & ! Число байт для хранения вспомогательной строки
                 & UP, & ! Точность целого числа номера дескриптора файла
                 & LP    ! Число байт для хранения логической переменной
implicit none
     
     private
     public :: input_type ! Тип, определяющий входные данные
     
     ! Тип, определяющий входные данные
     type input_type
          
          real(RP) :: delta_t ! Шаг выборки

          real(RP), allocatable, dimension(:) :: t ! Массив времени
          real(RP), allocatable, dimension(:) :: x ! Массив значений

          contains

          ! Процедура освобождения памяти из-под входных данных
          procedure :: deallocate => scats_input_deallocate

          ! Процедура для считывания входных данных из файла
          procedure :: read => scats_input_read

          ! Процедура для записи входных данных в файл
          procedure :: write => scats_input_write_to_file

          ! Процедура для присваивания значения шагу выборки
          procedure :: put_delta_t => scats_input_put_delta_t

          ! Функция для получения указателя на шаг выборки
          procedure :: get_delta_t_pt => scats_input_get_delta_t_pt

          ! Функция для получения указателя на массив времени
          procedure :: get_t_pt => scats_input_get_t_pt

          ! Функция для получения указателя на массив значений
          procedure :: get_x_pt => scats_input_get_x_pt          

     end type input_type

     interface
     
          ! Процедура освобождения памяти из-под входных данных
          module impure subroutine scats_input_deallocate(input)
          implicit none
          
               class( input_type ), intent(inout) :: input
          
          end subroutine scats_input_deallocate

          ! Процедура для вывода ошибок для других процедур, связанных с входными данными
          module impure subroutine scats_log_input_error(error_code, file)
          implicit none
               
               character(*), intent(in) :: error_code ! Код ошибки
               character(*), intent(in), optional :: file ! Имя файла для записи

          end subroutine scats_log_input_error

          ! Процедура для считывания входных данных
          module impure subroutine scats_input_read(input, file)
          implicit none
               
               class( input_type ), intent(inout) :: input ! Входные данные
               character(*), intent(in) :: file ! Файл для записи

          end subroutine scats_input_read

          ! Процедура для записи входных данных в файл
          module impure subroutine scats_input_write_to_file(input, file)
          implicit none
               
               class( input_type ), intent(in) :: input ! Входные данные
               character(*), intent(in) :: file ! Файл для записи

          end subroutine scats_input_write_to_file

          ! Процедура для присваивания значения шагу выборки
          module impure subroutine scats_input_put_delta_t(input, value)
          implicit none
               
               class( input_type ), intent(inout) :: input ! Входные данные
               real(RP) :: value ! Значение шага выборки

          end subroutine scats_input_put_delta_t

          ! Функция для получения указателя на шаг выборки
          module impure function scats_input_get_delta_t_pt(input) result(delta_t_pt)
          implicit none
               
               class( input_type ), intent(in), target :: input ! Входные данные
               real(RP), pointer :: delta_t_pt ! Указатель на шаг выборки

          end function scats_input_get_delta_t_pt

          ! Функция для получения указателя на массив времени
          module impure function scats_input_get_t_pt(input) result(t_pt)
          implicit none
               
               class( input_type ), intent(in), target :: input ! Входные данные
               real(RP), dimension(:), pointer :: t_pt ! Указатель на массив времени

          end function scats_input_get_t_pt

          ! Функция для получения указателя на массив значений
          module impure function scats_input_get_x_pt(input) result(x_pt)
          implicit none
               
               class( input_type ), intent(in), target :: input ! Входные данные
               real(RP), dimension(:), pointer :: x_pt ! Указатель на массив значений

          end function scats_input_get_x_pt

     end interface
     
end module scats_input_m