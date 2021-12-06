using SpikingNeuralNetworks
using ClearStacktrace
using Plots
unicodeplots()
SNN = SpikingNeuralNetworks
SNN.@load_units
#include("../current_search.jl")
using SpikeNetOpt
SNO = SpikeNetOpt
@testset "IZHI" begin

    RS = SNN.IZ(;N = 1, param = SNN.IZParameter(;a = 0.02, b = 0.2, c = -65, d = 8))
    IB = SNN.IZ(;N = 1, param = SNN.IZParameter(;a = 0.02, b = 0.2, c = -55, d = 4))
    CH = SNN.IZ(;N = 1, param = SNN.IZParameter(;a = 0.02, b = 0.2, c = -50, d = 2))
    FS = SNN.IZ(;N = 1, param = SNN.IZParameter(;a = 0.1, b = 0.2, c = -65, d = 2))
    TC1 = SNN.IZ(;N = 1, param = SNN.IZParameter(;a = 0.02, b = 0.25, c = -65, d = 0.05))
    TC2 = SNN.IZ(;N = 1, param = SNN.IZParameter(;a = 0.02, b = 0.25, c = -65, d = 0.05))
    RZ = SNN.IZ(;N = 1, param = SNN.IZParameter(;a = 0.1, b = 0.26, c = -65, d = 2))
    LTS = SNN.IZ(;N = 1, param = SNN.IZParameter(;a = 0.1, b = 0.25, c = -65, d = 2))
    P = [RS, IB, CH, FS, TC1, TC2, RZ, LTS]

    SNN.monitor(P, [:v])
    SNN.monitor(P, [:fire])

    T = 2second
    for t = 0:T
        for p in [RS, IB, CH, FS, LTS]
            p.I = [10]
        end
        TC1.I = [(t < 0.2T) ? 0mV : 2mV]
        TC2.I = [(t < 0.2T) ? -30mV : 0mV]
        RZ.I =  [(0.5T < t < 0.6T) ? 10mV : 0mV]
        SNN.sim!(P, [], 0.1ms)

        #test_result(nspk, ngt_spikes, 1e-1)

        #v = vecplot(E, :v)
        #@show(v)
    end
    for p in P
        spikes = SNO.get_spikes(p)
        spikes = [s*ms for s in spikes]
        nspk = size(spikes)[1]

        v = SNN.vecplot(p, :v)
        v |> display
        @test nspk>=1

    end
end
