*&---------------------------------------------------------------------*
*& Report ZSAM_GIT_TEST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSAM_GIT_DEMO.
Write 'Hi People'.
Write 'Adding new line'.
write 'write to another branch'.
write 'write from Eclipse tool'.
write 'pull from GIT'.
data: lv_val type n value 0.
      data: i_kna1 like kna1 occurs 0 with header line.
      select * from kna1 into table i_kna1.
write 'new line'.
write '5th March'.
