/////////////////////////////////////////////////////////////////////////////////
// Register map taken from Pololu VL53L0X open-source library on github        //
//																										 //
/////////////////////////////////////////////////////////////////////////////////
parameter SYSRANGE_START                              = 0x00;

parameter SYSTEM_THRESH_HIGH                          = 0x0C;
parameter SYSTEM_THRESH_LOW                           = 0x0E;

parameter SYSTEM_SEQUENCE_CONFIG                      = 0x01;
parameter SYSTEM_RANGE_CONFIG                         = 0x09;
parameter SYSTEM_INTERMEASUREMENT_PERIOD              = 0x04;

parameter SYSTEM_INTERRUPT_CONFIG_GPIO                = 0x0A;

parameter GPIO_HV_MUX_ACTIVE_HIGH                     = 0x84;

parameter SYSTEM_INTERRUPT_CLEAR                      = 0x0B;

parameter RESULT_INTERRUPT_STATUS                     = 0x13;
parameter RESULT_RANGE_STATUS                         = 0x14;

parameter RESULT_CORE_AMBIENT_WINDOW_EVENTS_RTN       = 0xBC;
parameter RESULT_CORE_RANGING_TOTAL_EVENTS_RTN        = 0xC0;
parameter RESULT_CORE_AMBIENT_WINDOW_EVENTS_REF       = 0xD0;
parameter RESULT_CORE_RANGING_TOTAL_EVENTS_REF        = 0xD4;
parameter RESULT_PEAK_SIGNAL_RATE_REF                 = 0xB6;

parameter ALGO_PART_TO_PART_RANGE_OFFSET_MM           = 0x28;

parameter I2C_SLAVE_DEVICE_ADDRESS                    = 0x8A;

parameter MSRC_CONFIG_CONTROL                         = 0x60;

parameter PRE_RANGE_CONFIG_MIN_SNR                    = 0x27;
parameter PRE_RANGE_CONFIG_VALID_PHASE_LOW            = 0x56;
parameter PRE_RANGE_CONFIG_VALID_PHASE_HIGH           = 0x57;
parameter PRE_RANGE_MIN_COUNT_RATE_RTN_LIMIT          = 0x64;

parameter FINAL_RANGE_CONFIG_MIN_SNR                  = 0x67;
parameter FINAL_RANGE_CONFIG_VALID_PHASE_LOW          = 0x47;
parameter FINAL_RANGE_CONFIG_VALID_PHASE_HIGH         = 0x48;
parameter FINAL_RANGE_CONFIG_MIN_COUNT_RATE_RTN_LIMIT = 0x44;

parameter PRE_RANGE_CONFIG_SIGMA_THRESH_HI            = 0x61;
parameter PRE_RANGE_CONFIG_SIGMA_THRESH_LO            = 0x62;
parameter PRE_RANGE_CONFIG_VCSEL_PERIOD               = 0x50;
parameter PRE_RANGE_CONFIG_TIMEOUT_MACROP_HI          = 0x51;
parameter PRE_RANGE_CONFIG_TIMEOUT_MACROP_LO          = 0x52;
parameter SYSTEM_HISTOGRAM_BIN                        = 0x81;
parameter HISTOGRAM_CONFIG_INITIAL_PHASE_SELECT       = 0x33;
parameter HISTOGRAM_CONFIG_READOUT_CTRL               = 0x55;
parameter FINAL_RANGE_CONFIG_VCSEL_PERIOD             = 0x70;
parameter FINAL_RANGE_CONFIG_TIMEOUT_MACROP_HI        = 0x71;
parameter FINAL_RANGE_CONFIG_TIMEOUT_MACROP_LO        = 0x72;
parameter CROSSTALK_COMPENSATION_PEAK_RATE_MCPS       = 0x20;
parameter MSRC_CONFIG_TIMEOUT_MACROP                  = 0x46;

parameter SOFT_RESET_GO2_SOFT_RESET_N                 = 0xBF;
parameter IDENTIFICATION_MODEL_ID                     = 0xC0;
parameter IDENTIFICATION_REVISION_ID                  = 0xC2;
parameter OSC_CALIBRATE_VAL                           = 0xF8;
parameter GLOBAL_CONFIG_VCSEL_WIDTH                   = 0x32;
parameter GLOBAL_CONFIG_SPAD_ENABLES_REF_0            = 0xB0;
parameter GLOBAL_CONFIG_SPAD_ENABLES_REF_1            = 0xB1;
parameter GLOBAL_CONFIG_SPAD_ENABLES_REF_2            = 0xB2;
parameter GLOBAL_CONFIG_SPAD_ENABLES_REF_3            = 0xB3;
parameter GLOBAL_CONFIG_SPAD_ENABLES_REF_4            = 0xB4;
parameter GLOBAL_CONFIG_SPAD_ENABLES_REF_5            = 0xB5;
parameter GLOBAL_CONFIG_REF_EN_START_SELECT           = 0xB6;
parameter DYNAMIC_SPAD_NUM_REQUESTED_REF_SPAD         = 0x4E;
parameter DYNAMIC_SPAD_REF_EN_START_OFFSET            = 0x4F;
parameter POWER_MANAGEMENT_GO1_POWER_FORCE            = 0x80;
parameter VHV_CONFIG_PAD_SCL_SDA__EXTSUP_HV           = 0x89;
parameter ALGO_PHASECAL_LIM                           = 0x30;
parameter ALGO_PHASECAL_CONFIG_TIMEOUT                = 0x30;

/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////