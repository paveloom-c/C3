submodule ( scats_result_m ) scats_result_write_to_file_s
implicit none
     
     contains
     
     ! Процедура для записи результата в файл
     module procedure scats_result_write_to_file
          
          integer(SP) :: stat ! Статусная переменная
          integer(UP) :: unit ! Номер дескриптора файла

          character(FP) :: f ! Вспомогательная строка

          ! Открытие файла
          open( newunit = unit, file = file, action = 'write', status = 'replace', iostat = stat)
          if ( stat .ne. 0_SP ) call scats_log_result_error('WO', file) ! Проверка на ошибку открытия файла

          if ( .not. allocated(result%t) ) then

               call scats_log_result_error('NA_t', file)

          else if ( .not. allocated(result%x) ) then

               call scats_log_result_error('NA_t', file)

          else

               ! Запись размера выборки
               write( unit, '(a)' ) 'Размер выборки'
               write( f, '(i10)' ) size(result%t)
               write( unit, '(a, /)' ) trim(adjustl(f))

               ! Запись массива времени
               write( unit, '(a)' ) 'Массив времени'
               write( unit, '(*('//RF//', 3x))' ) result%t
               write( unit, '()')

               ! Запись массива значений
               write( unit, '(a)' ) 'Массив значений'
               write( unit, '(*('//RF//', 3x))') result%x
               write( unit, '()')

          endif

          ! Закрытие файла
          close( unit = unit, iostat = stat )
          if ( stat .ne. 0_SP ) call scats_log_result_error('WC', file) ! Проверка на ошибку закрытия файла
          
     end procedure scats_result_write_to_file
     
end submodule scats_result_write_to_file_s