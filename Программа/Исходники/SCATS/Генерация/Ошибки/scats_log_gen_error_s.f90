submodule ( scats_gen_m ) scats_log_gen_error_s
implicit none

     contains

     ! Процедура для вывода ошибок для процедуры генерации
     module procedure scats_log_gen_error
          
          select case (error_code) ! Проверка кода ошибки

               case ('WA_t') ! Встречается в scats_gen_generate_s

                    write(*,'(/, 5x, a, /, 5x, a, /)') 'scats_log_gen_error:', 'Не удалось выделить память под массив времени&
                                                                              & для объекта типа input_type.'
                    stop

               case ('WA_x') ! Встречается в scats_gen_generate_s

                    write(*,'(/, 5x, a, /, 5x, a, /)') 'scats_log_gen_error:', 'Не удалось выделить память под массив значений&
                                                                              & для объекта типа input_type.'
                    stop

               case ('WD_t') ! Встречается в scats_gen_generate_s

                    write(*,'(/, 5x, a, /, 5x, a, /)') 'scats_log_gen_error:', 'Не удалось освободить память из-под&
                                                                              & массива времени объекта&
                                                                              & типа input_type.'

               case ('WD_x') ! Встречается в scats_gen_generate_s

                    write(*,'(/, 5x, a, /, 5x, a, /)') 'scats_log_gen_error:', 'Не удалось освободить память из-под&
                                                                              & массива значений объекта&
                                                                              & типа input_type.'

               case ('WA_rand') ! Встречается в scats_gen_generate_s

                    write(*,'(/, 5x, a, /, 5x, a, /)') 'scats_log_gen_error:', 'Не удалось выделить память под массив случайных&
                                                                              & чисел внутри процедуры scats_gen_generate.'
                    stop

               case ('WD_rand') ! Встречается в scats_gen_generate_s

                    write(*,'(/, 5x, a, /, 5x, a, /)') 'scats_log_gen_params_error:', 'Не удалось освободить память из-под&
                                                                                     & массива случайных чисел внутри&
                                                                                     & процедуры scats_gen_generate.'
                    stop

               case ('NA') ! Встречается в scats_gen_generate_s 

                    write(*,'(/, 5x, a, /, 5x, a, /)') 'scats_log_gen_params_error:', 'Генератор не был активирован,&
                                                                                     & генерация будет пропущена.'

               case default

                    write(*,'(/, 5x, a, /, 5x, a, /)') 'scats_log_gen_params_error:', 'Неизвестный код ошибки ('//error_code//').'

          end select

     end procedure scats_log_gen_error

end submodule scats_log_gen_error_s