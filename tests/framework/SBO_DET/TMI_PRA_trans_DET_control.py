import sys
import math
import distribution1D
import crowtools
# initialize distribution container

def restart_function(monitored, controlled, auxiliary):
    # here we store some critical parameters that we want in the output
    if auxiliary.CladDamaged and auxiliary.CladTempBranched == 0:
        auxiliary.CladTempBranched = max(monitored.avg_temp_clad_CH1,monitored.avg_temp_clad_CH2,monitored.avg_temp_clad_CH3)
    if auxiliary.crew1DG1 and auxiliary.DG1recoveryTime == 0.0:
        auxiliary.DG1recoveryTime = monitored.time
        auxiliary.DG1_time_ratio = 0
    if auxiliary.crew1DG2CoupledDG1 and auxiliary.DG2recoveryTime == 0.0:
        auxiliary.DG2recoveryTime = monitored.time
    if auxiliary.crewSecPG and auxiliary.SecPGrecoveryTime == 0.0:
        auxiliary.SecPGrecoveryTime = monitored.time
    if auxiliary.PrimPGrecovery and auxiliary.PrimPGrecoveryTime == 0.0:
        auxiliary.PrimPGrecoveryTime = monitored.time
    auxiliary.CladFailureDistThreshold = distributions.CladFailureDist.getVariable('ProbabilityThreshold')
    auxiliary.CladTempBranched = distributions.CladFailureDist.inverseCdf(auxiliary.CladFailureDistThreshold)
    auxiliary.crew1DG1Threshold = distributions.crew1DG1.getVariable('ProbabilityThreshold')
    auxiliary.DG1recoveryTime = distributions.crew1DG1.inverseCdf(auxiliary.crew1DG1Threshold)
    auxiliary.crew1DG2CoupledDG1Threshold = distributions.crew1DG2CoupledDG1.getVariable('ProbabilityThreshold')
    auxiliary.DG2recoveryTime = auxiliary.DG1recoveryTime*distributions.crew1DG2CoupledDG1.inverseCdf(auxiliary.crew1DG2CoupledDG1Threshold)
    auxiliary.crewSecPGThreshold = distributions.crewSecPG.getVariable('ProbabilityThreshold')
    auxiliary.SecPGrecoveryTime = distributions.crewSecPG.inverseCdf(auxiliary.crewSecPGThreshold)
    auxiliary.PrimPGrecoveryThreshold = distributions.PrimPGrecovery.getVariable('ProbabilityThreshold')
    auxiliary.PrimPGrecoveryTime= distributions.PrimPGrecovery.inverseCdf(auxiliary.PrimPGrecoveryThreshold)
    # here we check the variables one by one (for the aux)
    if (auxiliary.crew1DG1 and auxiliary.crew1DG2CoupledDG1) and not auxiliary.AuxSystemUp:
        auxiliary.AuxSystemUp =  True
    if auxiliary.crew1DG2CoupledDG1 and not auxiliary.AuxSystemUp:
        auxiliary.AuxSystemUp =  True
    if auxiliary.crewSecPG and not auxiliary.AuxSystemUp:
        auxiliary.AuxSystemUp =  True
    if auxiliary.PrimPGrecovery and not auxiliary.AuxSystemUp:
        auxiliary.AuxSystemUp =  True

    return


def initial_function(monitored, controlled, auxiliary):
    auxiliary.CladFailureDistThreshold = distributions.CladFailureDist.getVariable('ProbabilityThreshold')
    auxiliary.CladTempBranched = distributions.CladFailureDist.inverseCdf(auxiliary.CladFailureDistThreshold)
    auxiliary.crew1DG1Threshold = distributions.crew1DG1.getVariable('ProbabilityThreshold')
    auxiliary.DG1recoveryTime = distributions.crew1DG1.inverseCdf(auxiliary.crew1DG1Threshold)
    auxiliary.crew1DG2CoupledDG1Threshold = distributions.crew1DG2CoupledDG1.getVariable('ProbabilityThreshold')
    auxiliary.DG2recoveryTime = auxiliary.DG1recoveryTime*distributions.crew1DG2CoupledDG1.inverseCdf(auxiliary.crew1DG2CoupledDG1Threshold)
    auxiliary.crewSecPGThreshold = distributions.crewSecPG.getVariable('ProbabilityThreshold')
    auxiliary.SecPGrecoveryTime = distributions.crewSecPG.inverseCdf(auxiliary.crewSecPGThreshold)
    auxiliary.PrimPGrecoveryThreshold = distributions.PrimPGrecovery.getVariable('ProbabilityThreshold')
    auxiliary.PrimPGrecoveryTime= distributions.PrimPGrecovery.inverseCdf(auxiliary.PrimPGrecoveryThreshold)
    return

def control_function(monitored, controlled, auxiliary):

    if auxiliary.CladDamaged and auxiliary.CladTempBranched == 0:
        auxiliary.CladTempBranched = max(monitored.avg_temp_clad_CH1,monitored.avg_temp_clad_CH2,monitored.avg_temp_clad_CH3)
    if auxiliary.crew1DG1 and auxiliary.DG1recoveryTime == 0.0:
        auxiliary.DG1recoveryTime = monitored.time
        auxiliary.DG1_time_ratio = 0
    if auxiliary.crew1DG2CoupledDG1 and auxiliary.DG2recoveryTime == 0.0:
        auxiliary.DG2recoveryTime = monitored.time
    if auxiliary.crewSecPG and auxiliary.SecPGrecoveryTime == 0.0:
        auxiliary.SecPGrecoveryTime = monitored.time
    if auxiliary.PrimPGrecovery and auxiliary.PrimPGrecoveryTime == 0.0:
        auxiliary.PrimPGrecoveryTime = monitored.time
    auxiliary.CladFailureDistThreshold = distributions.CladFailureDist.getVariable('ProbabilityThreshold')
    auxiliary.CladTempBranched = distributions.CladFailureDist.inverseCdf(auxiliary.CladFailureDistThreshold)
    auxiliary.crew1DG1Threshold = distributions.crew1DG1.getVariable('ProbabilityThreshold')
    auxiliary.DG1recoveryTime = distributions.crew1DG1.inverseCdf(auxiliary.crew1DG1Threshold)
    auxiliary.crew1DG2CoupledDG1Threshold = distributions.crew1DG2CoupledDG1.getVariable('ProbabilityThreshold')
    auxiliary.DG2recoveryTime = auxiliary.DG1recoveryTime*distributions.crew1DG2CoupledDG1.inverseCdf(auxiliary.crew1DG2CoupledDG1Threshold)
    auxiliary.crewSecPGThreshold = distributions.crewSecPG.getVariable('ProbabilityThreshold')
    auxiliary.SecPGrecoveryTime = distributions.crewSecPG.inverseCdf(auxiliary.crewSecPGThreshold)
    auxiliary.PrimPGrecoveryThreshold = distributions.PrimPGrecovery.getVariable('ProbabilityThreshold')
    auxiliary.PrimPGrecoveryTime= distributions.PrimPGrecovery.inverseCdf(auxiliary.PrimPGrecoveryThreshold)
    # here we check the variables one by one (for the aux)
    if (auxiliary.crew1DG1 and auxiliary.crew1DG2CoupledDG1) and not auxiliary.AuxSystemUp:
        auxiliary.AuxSystemUp =  True
    if auxiliary.crew1DG2CoupledDG1 and not auxiliary.AuxSystemUp:
        auxiliary.AuxSystemUp =  True
    if auxiliary.crewSecPG and not auxiliary.AuxSystemUp:
        auxiliary.AuxSystemUp =  True
    if auxiliary.PrimPGrecovery and not auxiliary.AuxSystemUp:
        auxiliary.AuxSystemUp =  True

    if auxiliary.crew1DG1 and not auxiliary.crew1DG2CoupledDG1:
        auxiliary.DG1_time_ratio = (monitored.time - auxiliary.DG1recoveryTime)/auxiliary.DG1recoveryTime
    else:
        auxiliary.DG1_time_ratio = 0

    if auxiliary.CladDamaged:
        if monitored.time_step > 1:
            raise NameError ('exit condition reached - failure of the clad')
    auxiliary.a_power_CH1 = controlled.power_CH1
    auxiliary.a_power_CH2 = controlled.power_CH2
    auxiliary.a_power_CH3 = controlled.power_CH3
    auxiliary.a_friction2_CL_B = controlled.friction2_CL_B
    auxiliary.a_friction1_CL_B = controlled.friction1_CL_B
    auxiliary.a_friction2_SC_B = controlled.friction2_SC_B
    auxiliary.a_friction1_SC_B = controlled.friction1_SC_B
    auxiliary.a_friction2_CL_A = controlled.friction2_CL_A
    auxiliary.a_friction1_CL_A = controlled.friction1_CL_A
    auxiliary.a_friction2_SC_A = controlled.friction2_SC_A
    auxiliary.a_friction1_SC_A = controlled.friction1_SC_A
    auxiliary.a_Head_PumpB     = controlled.Head_PumpB
    auxiliary.a_Head_PumpA     = controlled.Head_PumpA
    auxiliary.a_MassFlowRateIn_SC_B = controlled.MassFlowRateIn_SC_B
    auxiliary.a_MassFlowRateIn_SC_A = controlled.MassFlowRateIn_SC_A

    if monitored.time>=auxiliary.scram_start_time:
        auxiliary.ScramStatus = True
        print('SCRAM')
    else:
        auxiliary.ScramStatus = False
        print('OPERATIONAL STATE')
    #
    if auxiliary.ScramStatus: #we are in scram
        #primary pump B
        if auxiliary.a_Head_PumpB>1.e-4*8.9:
            if not auxiliary.AuxSystemUp: # not yet auxiliary system up
                auxiliary.a_Head_PumpB = tools.PumpCoastDown.compute(monitored.time-auxiliary.scram_start_time)
                if auxiliary.a_Head_PumpB < (1.e-4*8.9):
                    auxiliary.a_Head_PumpB = 1.e-4*8.9
                auxiliary.a_friction1_SC_B = auxiliary.frict_m*auxiliary.a_Head_PumpB + auxiliary.frict_q
                auxiliary.a_friction2_SC_B = auxiliary.frict_m*auxiliary.a_Head_PumpB + auxiliary.frict_q
                auxiliary.a_friction1_CL_B = auxiliary.frict_m*auxiliary.a_Head_PumpB + auxiliary.frict_q
                auxiliary.a_friction2_CL_B = auxiliary.frict_m*auxiliary.a_Head_PumpB + auxiliary.frict_q
            else: #system up
                if auxiliary.init_exp_frict:
                    auxiliary.friction_time_start_exp = auxiliary.a_friction1_SC_B
                    auxiliary.init_exp_frict = False
                if auxiliary.a_Head_PumpB <= 0.05*8.9:
                    auxiliary.a_Head_PumpB = auxiliary.a_Head_PumpB*1.5
                    if auxiliary.a_Head_PumpB > 0.05*8.9:
                        auxiliary.a_Head_PumpB = 0.05*8.9
                    if auxiliary.a_friction1_SC_B > 0.1:
                        auxiliary.a_friction1_SC_B = auxiliary.friction_time_start_exp*math.exp(-(monitored.time-(auxiliary.scram_start_time++100.0))/4.0)
                        auxiliary.a_friction2_SC_B = auxiliary.a_friction1_SC_B
                        auxiliary.a_friction1_CL_B = auxiliary.a_friction1_SC_B
                        auxiliary.a_friction2_CL_B = auxiliary.a_friction1_SC_B
                    else:
                        auxiliary.a_friction1_SC_B = 0.1
                        auxiliary.a_friction2_SC_B = 0.1
                        auxiliary.a_friction1_CL_B = 0.1
                        auxiliary.a_friction2_CL_B = 0.1
                else:
                    auxiliary.a_Head_PumpB = tools.PumpCoastDown.compute(monitored.time-auxiliary.scram_start_time)
                    if auxiliary.a_Head_PumpB < (1.e-4*8.9):
                        auxiliary.a_Head_PumpB = 1.e-4*8.9
                    if auxiliary.a_friction1_SC_B > 0.1:
                        auxiliary.a_friction1_SC_B = auxiliary.friction_time_start_exp*math.exp(-(monitored.time-(auxiliary.scram_start_time++100.0))/4.0)
                        auxiliary.a_friction2_SC_B = auxiliary.a_friction1_SC_B
                        auxiliary.a_friction1_CL_B = auxiliary.a_friction1_SC_B
                        auxiliary.a_friction2_CL_B = auxiliary.a_friction1_SC_B
                    else:
                        auxiliary.a_friction1_SC_B = 0.1
                        auxiliary.a_friction2_SC_B = 0.1
                        auxiliary.a_friction1_CL_B = 0.1
                        auxiliary.a_friction2_CL_B = 0.1
        else:
            if not auxiliary.AuxSystemUp: # not yet auxiliary system up
                auxiliary.a_Head_PumpB = 1.e-4*8.9
                auxiliary.a_friction1_SC_B = 15000
                auxiliary.a_friction2_SC_B = 15000
                auxiliary.a_friction1_CL_B = 15000
                auxiliary.a_friction2_CL_B = 15000
            else:
                if auxiliary.init_exp_frict:
                    auxiliary.friction_time_start_exp = auxiliary.a_friction1_SC_B
                    auxiliary.init_exp_frict = False
                if auxiliary.a_Head_PumpB <= 0.05*8.9:
                    auxiliary.a_Head_PumpB = auxiliary.a_Head_PumpB*1.5
                    if auxiliary.a_Head_PumpB > 0.05*8.9:
                        auxiliary.a_Head_PumpB = 0.05*8.9
                    if auxiliary.a_friction1_SC_B > 0.1:
                        auxiliary.a_friction1_SC_B = auxiliary.friction_time_start_exp*math.exp(-(monitored.time-(auxiliary.scram_start_time++100.0))/4.0)
                        auxiliary.a_friction2_SC_B = auxiliary.a_friction1_SC_B
                        auxiliary.a_friction1_CL_B = auxiliary.a_friction1_SC_B
                        auxiliary.a_friction2_CL_B = auxiliary.a_friction1_SC_B
                    else:
                        auxiliary.a_friction1_SC_B = 0.1
                        auxiliary.a_friction2_SC_B = 0.1
                        auxiliary.a_friction1_CL_B = 0.1
                        auxiliary.a_friction2_CL_B = 0.1
                else:
                    auxiliary.a_Head_PumpB = tools.PumpCoastDown.compute(monitored.time-auxiliary.scram_start_time)
                    auxiliary.a_friction1_SC_B = auxiliary.frict_m*auxiliary.a_Head_PumpB + auxiliary.frict_q
                    auxiliary.a_friction2_SC_B = auxiliary.frict_m*auxiliary.a_Head_PumpB + auxiliary.frict_q
                    auxiliary.a_friction1_CL_B = auxiliary.frict_m*auxiliary.a_Head_PumpB + auxiliary.frict_q
                    auxiliary.a_friction2_CL_B = auxiliary.frict_m*auxiliary.a_Head_PumpB + auxiliary.frict_q
        #primary pump A
        auxiliary.a_Head_PumpA     = auxiliary.a_Head_PumpB
        auxiliary.a_friction1_SC_A = auxiliary.a_friction1_SC_B
        auxiliary.a_friction2_SC_A = auxiliary.a_friction2_SC_B
        auxiliary.a_friction1_CL_A = auxiliary.a_friction1_CL_B
        auxiliary.a_friction2_CL_A = auxiliary.a_friction2_CL_B

        #core power following decay heat curve
        auxiliary.a_power_CH1 = auxiliary.init_Power_Fraction_CH1*tools.DecayHeatScalingFactor.compute(monitored.time-auxiliary.scram_start_time)
        auxiliary.a_power_CH2 = auxiliary.init_Power_Fraction_CH2*tools.DecayHeatScalingFactor.compute(monitored.time-auxiliary.scram_start_time)
        auxiliary.a_power_CH3 = auxiliary.init_Power_Fraction_CH3*tools.DecayHeatScalingFactor.compute(monitored.time-auxiliary.scram_start_time)
    #secondary system replaced by auxiliary secondary system
    if not auxiliary.AuxSystemUp and auxiliary.ScramStatus: # not yet auxiliary system up
        print('not yet auxiliary system up')
        auxiliary.a_MassFlowRateIn_SC_B = 2.542*tools.PumpCoastDownSec.compute(monitored.time-auxiliary.scram_start_time)
        auxiliary.a_MassFlowRateIn_SC_A = 2.542*tools.PumpCoastDownSec.compute(monitored.time-auxiliary.scram_start_time)
        if auxiliary.a_MassFlowRateIn_SC_A < (1.e-4*2.542):
            auxiliary.a_MassFlowRateIn_SC_A = 1.e-4*2.542
            auxiliary.a_MassFlowRateIn_SC_B = 1.e-4*2.542
    if auxiliary.AuxSystemUp and auxiliary.ScramStatus: # auxiliary system up
        print('auxiliary system up')
        auxiliary.a_MassFlowRateIn_SC_B = auxiliary.a_MassFlowRateIn_SC_B*1.5
        auxiliary.a_MassFlowRateIn_SC_A = auxiliary.a_MassFlowRateIn_SC_B
        if auxiliary.a_MassFlowRateIn_SC_B > 2.542*0.05:
            auxiliary.a_MassFlowRateIn_SC_B = 2.542*0.05
            auxiliary.a_MassFlowRateIn_SC_A = 2.542*0.05
    # we work on auxiliaries and we store them back into controlleds
    controlled.power_CH1 = auxiliary.a_power_CH1
    controlled.power_CH2 = auxiliary.a_power_CH2
    controlled.power_CH3 = auxiliary.a_power_CH3
    controlled.friction2_CL_B = auxiliary.a_friction2_CL_B
    controlled.friction1_CL_B = auxiliary.a_friction1_CL_B
    controlled.friction2_SC_B = auxiliary.a_friction2_SC_B
    controlled.friction1_SC_B = auxiliary.a_friction1_SC_B
    controlled.friction2_CL_A = auxiliary.a_friction2_CL_A
    controlled.friction1_CL_A = auxiliary.a_friction1_CL_A
    controlled.friction2_SC_A = auxiliary.a_friction2_SC_A
    controlled.friction1_SC_A = auxiliary.a_friction1_SC_A
    controlled.Head_PumpB = auxiliary.a_Head_PumpB
    controlled.Head_PumpA = auxiliary.a_Head_PumpA
    controlled.MassFlowRateIn_SC_B = auxiliary.a_MassFlowRateIn_SC_B
    controlled.MassFlowRateIn_SC_A = auxiliary.a_MassFlowRateIn_SC_A
    #if auxiliary.CladDamaged:
    #    raise NameError ('exit condition reached - failure of the clad')
    return

def dynamic_event_tree(monitored, controlled, auxiliary):
    if distributions.CladFailureDist.checkCdf(monitored.avg_temp_clad_CH1) and (not auxiliary.CladDamaged):
        auxiliary.CladDamaged = True
        return
    if distributions.CladFailureDist.checkCdf(monitored.avg_temp_clad_CH2) and (not auxiliary.CladDamaged):
        auxiliary.CladDamaged = True
        return
    if distributions.CladFailureDist.checkCdf(monitored.avg_temp_clad_CH3) and (not auxiliary.CladDamaged):
        auxiliary.CladDamaged = True
        return
    if distributions.crew1DG1.checkCdf(monitored.time - auxiliary.scram_start_time - 100.0) and (not auxiliary.CladDamaged) and (not auxiliary.crew1DG1):
        auxiliary.crew1DG1 = True
        return
    if auxiliary.crew1DG1 and distributions.crew1DG2CoupledDG1.checkCdf(auxiliary.DG1_time_ratio) and (not auxiliary.CladDamaged) and (not auxiliary.crew1DG2CoupledDG1) and (not auxiliary.AuxSystemUp):
        auxiliary.crew1DG2CoupledDG1 = True
        return
    if distributions.crewSecPG.checkCdf(monitored.time - auxiliary.scram_start_time - 400.0) and (not auxiliary.CladDamaged) and (not auxiliary.crewSecPG) and (not auxiliary.AuxSystemUp):
        auxiliary.crewSecPG = True
        return
    if distributions.PrimPGrecovery.checkCdf(monitored.time - auxiliary.scram_start_time) and (not auxiliary.CladDamaged) and (not auxiliary.PrimPGrecovery) and (not auxiliary.AuxSystemUp):
        auxiliary.PrimPGrecovery = True
        return
    return
