restart -f -nowave
view signals wave
config wave -signalnamewidth 1
set NumericStdNoWarnings 1
.main clear


add wave  uart_txd_tb  
add wave clk_enable_tb


add wave inst/cnt_clk_tx
  
add wave inst/cnt_tx
add wave inst/uart_enable
add wave -radix decimal inst/cnt_read_cip
add wave inst/tx_flag
add wave inst/cnt_start
add wave inst/enb




run 100000000 ns