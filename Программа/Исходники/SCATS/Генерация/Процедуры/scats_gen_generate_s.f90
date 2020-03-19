submodule ( scats_gen_m ) scats_gen_generate_s
implicit none
     
     contains
     
     ! Процедура для вызова генератора временного ряда
     module procedure scats_gen_generate

          integer(SP) :: stat ! Статусная переменная

          ! Содержимое объекта типа gen_params_type

          integer(IP), pointer :: N_pt ! Указатель на размер выборки

          real(RP), pointer :: delta_t_pt ! Указатель на шаг выборки
          real(RP), pointer :: q_pt ! Указатель на уровень значимости
          real(RP), pointer :: alpha_pt, beta_pt ! Указатель на параметры линейного тренда
          
          integer(IP), pointer :: r_pt ! Указатель на число гармонических компонент

          real(RP), dimension(:), pointer :: A_pt ! Указатель на массив амплитуд
          real(RP), dimension(:), pointer :: v_pt ! Указатель на массив частот
          real(RP), dimension(:), pointer :: phi_pt ! Указатель на массив фазовых сдвигов

          real(RP), pointer :: gamma_pt ! Указатель на отношение «сигнал к шуму»

          logical(LP), pointer :: ready_pt ! Указатель на флаг, отвечающий за готовность генератора

          ! Массив значений случайных чисел
          real(RP), allocatable, dimension(:) :: rand

          ! Дополнительные переменные
          real(RP) :: t ! Текущее значение времени
          real(RP) :: c ! Текущее значение суммы
          real(RP) :: std ! Стандартное отклонение

          ! Вспомогательные переменные
          integer(JP) :: N_JP ! Значение N (для индекса)
          integer(IP) :: N_m1 ! Значение N - 1
          integer(JP) :: N_m1_JP ! Значение N - 1 (для индекса)
          integer(JP) :: r_JP ! Значение r (для индекса)
          integer(JP) :: k ! Счетчик 1
          integer(JP) :: l ! Счетчик 2
          real(RP) :: k_RP ! Овеществление счетчика

          ! Получение флага готовности
          ready_pt => gen%params%get_ready_pt()

          ! Проверка, активирован ли генератор
          if (.not. ready_pt) call scats_log_gen_error('NA')

          ! Распаковка параметров генератора

          N_pt => gen%params%get_N_pt()

          delta_t_pt => gen%params%get_delta_t_pt()
          q_pt => gen%params%get_q_pt()
          alpha_pt => gen%params%get_alpha_pt()
          beta_pt => gen%params%get_beta_pt()

          r_pt => gen%params%get_r_pt()

          A_pt => gen%params%get_A_pt()
          v_pt => gen%params%get_v_pt()
          phi_pt => gen%params%get_phi_pt()

          gamma_pt => gen%params%get_gamma_pt()

          ! Сохранение значение шага выборки
          call input%put_delta_t(delta_t_pt)

          ! Вычисление стандартного отклонения
          std = sqrt(sum(A_pt * A_pt) / (2._RP * gamma_pt))

          ! Вычисление вспомогательной переменной
          N_m1 = N_pt - 1_IP

          ! Конвертации для индексов
          N_JP = int(N_pt, kind=JP)
          N_m1_JP = int(N_m1, kind=JP)
          r_JP = int(r_pt, kind=JP)

          ! Выделение памяти под массивы

          if ( allocated(input%t) ) then

               if ( .not. size(input%t, kind=IP) .eq. N_pt ) then

                    ! Освобождение памяти из-под массива времени
                    deallocate( input%t, stat = stat )
                    if ( stat .ne. 0_SP ) call scats_log_gen_error('WD_t')

                    ! Выделение памяти под массив времени
                    allocate( input%t(0:N_m1_JP), stat = stat )
                    if ( stat .ne. 0_SP ) call scats_log_gen_error('WA_t')

               endif

          else

               ! Выделение памяти под массив времени
               allocate( input%t(0:N_m1_JP), stat = stat )
               if ( stat .ne. 0_SP ) call scats_log_gen_error('WA_t')

          endif

          if ( allocated(input%x) ) then

               if ( .not. size(input%x, kind=IP) .eq. N_pt ) then

                    ! Освобождение памяти из-под массива значений
                    deallocate( input%x, stat = stat )
                    if ( stat .ne. 0_SP ) call scats_log_gen_error('WD_x')

                    ! Выделение памяти под массив значений
                    allocate( input%x(0:N_m1_JP), stat = stat )
                    if ( stat .ne. 0_SP ) call scats_log_gen_error('WA_x')

               endif

          else

               ! Выделение памяти под массив значений
               allocate( input%x(0:N_m1_JP), stat = stat )
               if ( stat .ne. 0_SP ) call scats_log_gen_error('WA_x')

          endif

          allocate( rand(0:N_m1_JP), stat = stat )
          if ( stat .ne. 0_SP ) call scats_log_gen_error('WA_rand')

          ! Генерация массива случайных чисел
          call scats_generate_random_array(N_JP, rand)

          ! Генерация временного ряда

          do k = 0_JP, N_m1_JP

               k_RP = real(k, kind=RP)

               t = delta_t_pt * k_RP
               input%t(k) = t

               c = alpha_pt + beta_pt * t

               do l = 1_JP, r_JP

                    c = c + A_pt(l) * cos(2._RP * pi * v_pt(l) * t - phi_pt(l))

               enddo

               c = c + rand(k)

               input%x(k) = c

          enddo

          deallocate( rand, stat = stat )
          if ( stat .ne. 0_SP ) call scats_log_gen_error('WD_rand')
          
     end procedure scats_gen_generate
     
end submodule scats_gen_generate_s