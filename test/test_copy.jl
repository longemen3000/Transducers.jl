module TestCopy

include("preamble.jl")
using DataFrames: DataFrame
using StructArrays: StructVector
using TypedTables: Table

@testset "copy [base types]" begin
    @test copy(Map(x -> x^2), Vector, 1:3) == (1:3) .^ 2
    @test copy(Map(x -> x^2), [1:3;]) == (1:3) .^ 2
    @test copy(Map(x -> x^2), Set, 1:3) == Set((1:3) .^ 2)
    @test copy(Map(x -> x => x^2), Dict, 2:2) == Dict(2 => 4)
end

@testset "$copy" for copy in [copy, tcopy, dcopy]
    @testset "$copy(_, ::$(prettytypeof(src)))" for src in Any[
        # DataFrame(a=[1], b=[2]),
        StructVector(a=[1], b=[2]),
        Table(a=[1], b=[2]),
    ]
        @test copy(Map(identity), src) == src
    end
end

end  # module
