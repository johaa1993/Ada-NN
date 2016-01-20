pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main.adb");
pragma Suppress (Overflow_Check);
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

   E074 : Short_Integer; pragma Import (Ada, E074, "system__os_lib_E");
   E013 : Short_Integer; pragma Import (Ada, E013, "system__soft_links_E");
   E096 : Short_Integer; pragma Import (Ada, E096, "system__fat_flt_E");
   E084 : Short_Integer; pragma Import (Ada, E084, "system__fat_llf_E");
   E023 : Short_Integer; pragma Import (Ada, E023, "system__exception_table_E");
   E048 : Short_Integer; pragma Import (Ada, E048, "ada__io_exceptions_E");
   E117 : Short_Integer; pragma Import (Ada, E117, "ada__numerics_E");
   E132 : Short_Integer; pragma Import (Ada, E132, "ada__strings_E");
   E136 : Short_Integer; pragma Import (Ada, E136, "ada__strings__maps_E");
   E050 : Short_Integer; pragma Import (Ada, E050, "ada__tags_E");
   E047 : Short_Integer; pragma Import (Ada, E047, "ada__streams_E");
   E072 : Short_Integer; pragma Import (Ada, E072, "interfaces__c_E");
   E025 : Short_Integer; pragma Import (Ada, E025, "system__exceptions_E");
   E077 : Short_Integer; pragma Import (Ada, E077, "system__file_control_block_E");
   E066 : Short_Integer; pragma Import (Ada, E066, "system__file_io_E");
   E070 : Short_Integer; pragma Import (Ada, E070, "system__finalization_root_E");
   E068 : Short_Integer; pragma Import (Ada, E068, "ada__finalization_E");
   E125 : Short_Integer; pragma Import (Ada, E125, "ada__calendar_E");
   E123 : Short_Integer; pragma Import (Ada, E123, "system__random_seed_E");
   E017 : Short_Integer; pragma Import (Ada, E017, "system__secondary_stack_E");
   E045 : Short_Integer; pragma Import (Ada, E045, "ada__text_io_E");
   E144 : Short_Integer; pragma Import (Ada, E144, "mathematics_E");
   E151 : Short_Integer; pragma Import (Ada, E151, "nn_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E045 := E045 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "ada__text_io__finalize_spec");
      begin
         F1;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "system__file_io__finalize_body");
      begin
         E066 := E066 - 1;
         F2;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (C, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Leap_Seconds_Support : Integer;
      pragma Import (C, Leap_Seconds_Support, "__gl_leap_seconds_support");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;
      Leap_Seconds_Support := 0;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      System.Soft_Links'Elab_Spec;
      System.Fat_Flt'Elab_Spec;
      E096 := E096 + 1;
      System.Fat_Llf'Elab_Spec;
      E084 := E084 + 1;
      System.Exception_Table'Elab_Body;
      E023 := E023 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E048 := E048 + 1;
      Ada.Numerics'Elab_Spec;
      E117 := E117 + 1;
      Ada.Strings'Elab_Spec;
      E132 := E132 + 1;
      Ada.Strings.Maps'Elab_Spec;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E047 := E047 + 1;
      Interfaces.C'Elab_Spec;
      System.Exceptions'Elab_Spec;
      E025 := E025 + 1;
      System.File_Control_Block'Elab_Spec;
      E077 := E077 + 1;
      System.Finalization_Root'Elab_Spec;
      E070 := E070 + 1;
      Ada.Finalization'Elab_Spec;
      E068 := E068 + 1;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E125 := E125 + 1;
      System.Random_Seed'Elab_Body;
      E123 := E123 + 1;
      System.File_Io'Elab_Body;
      E066 := E066 + 1;
      E072 := E072 + 1;
      Ada.Tags'Elab_Body;
      E050 := E050 + 1;
      E136 := E136 + 1;
      System.Soft_Links'Elab_Body;
      E013 := E013 + 1;
      System.Os_Lib'Elab_Body;
      E074 := E074 + 1;
      System.Secondary_Stack'Elab_Body;
      E017 := E017 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E045 := E045 + 1;
      E144 := E144 + 1;
      E151 := E151 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_main");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      gnat_argc := argc;
      gnat_argv := argv;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   C:\Users\Johan\Documents\GitHub\Ada-NN\obj\Mathematics.o
   --   C:\Users\Johan\Documents\GitHub\Ada-NN\obj\nn.o
   --   C:\Users\Johan\Documents\GitHub\Ada-NN\obj\main.o
   --   -LC:\Users\Johan\Documents\GitHub\Ada-NN\obj\
   --   -LC:\Users\Johan\Documents\GitHub\Ada-NN\obj\
   --   -LC:/gnat/2015/lib/gcc/i686-pc-mingw32/4.9.3/adalib/
   --   -static
   --   -lgnat
   --   -Wl,--stack=0x2000000
--  END Object file/option list   

end ada_main;
