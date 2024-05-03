\entry{functionality features overview}{1}{functionality features overview}
\entry{efficiency features overview}{1}{efficiency features overview}
\entry{speed for JVM}{2}{speed for JVM}
\entry{interpreters, advantages}{3}{interpreters, advantages}
\entry{advantages of interpreters}{3}{advantages of interpreters}
\entry{advantages of vmgen}{3}{advantages of vmgen}
\entry{speed of interpreters}{3}{speed of interpreters}
\entry{modularization of interpreters}{4}{modularization of interpreters}
\entry{front-end}{4}{front-end}
\entry{virtual machine}{4}{virtual machine}
\entry{VM}{4}{VM}
\entry{VM instruction}{4}{VM instruction}
\entry{instruction, VM}{4}{instruction, VM}
\entry{VM branch instruction}{4}{VM branch instruction}
\entry{branch instruction, VM}{4}{branch instruction, VM}
\entry{VM register}{4}{VM register}
\entry{register, VM}{4}{register, VM}
\entry{opcode, VM instruction}{4}{opcode, VM instruction}
\entry{immediate argument, VM instruction}{4}{immediate argument, VM instruction}
\entry{stack machine}{4}{stack machine}
\entry{register machine}{4}{register machine}
\entry{stack item size}{4}{stack item size}
\entry{size, stack items}{4}{size, stack items}
\entry{instruction stream}{4}{instruction stream}
\entry{immediate arguments}{4}{immediate arguments}
\entry{garbage collection}{4}{garbage collection}
\entry{reference counting}{4}{reference counting}
\entry{Dispatch of VM instructions}{5}{Dispatch of VM instructions}
\entry{main interpreter loop}{5}{main interpreter loop}
\entry{switch dispatch}{5}{switch dispatch}
\entry{threaded code}{5}{threaded code}
\entry{Invoking Vmgen}{6}{Invoking Vmgen}
\entry{-h, command-line option}{6}{-h, command-line option}
\entry{--help, command-line option}{6}{--help, command-line option}
\entry{-v, command-line option}{6}{-v, command-line option}
\entry{--version, command-line option}{6}{--version, command-line option}
\entry{example of a Vmgen-based interpreter}{7}{example of a Vmgen-based interpreter}
\entry{example overview}{7}{example overview}
\entry{vmgen-ex}{7}{\file {vmgen-ex}}
\entry{vmgen-ex2}{7}{\file {vmgen-ex2}}
\entry{unions example}{7}{unions example}
\entry{casts example}{7}{casts example}
\entry{example files}{7}{example files}
\entry{wrapper files}{7}{wrapper files}
\entry{profiling example}{8}{profiling example}
\entry{superinstructions example}{8}{superinstructions example}
\entry{input file format}{9}{input file format}
\entry{format, input file}{9}{format, input file}
\entry{grammar, input file}{9}{grammar, input file}
\entry{input file grammar}{9}{input file grammar}
\entry{free-format, not}{9}{free-format, not}
\entry{newlines, significance in syntax}{9}{newlines, significance in syntax}
\entry{C escape}{9}{C escape}
\entry{{\indexbackslash}C}{9}{\code {\backslashchar {}C}}
\entry{conditional compilation of Vmgen output}{9}{conditional compilation of Vmgen output}
\entry{sync lines}{9}{sync lines}
\entry{#line}{9}{\code {#line}}
\entry{escape to Forth}{10}{escape to Forth}
\entry{eval escape}{10}{eval escape}
\entry{{\indexbackslash}E}{10}{\code {\backslashchar {}E}}
\entry{simple VM instruction}{10}{simple VM instruction}
\entry{instruction, simple VM}{10}{instruction, simple VM}
\entry{stack effect}{10}{stack effect}
\entry{effect, stack}{10}{effect, stack}
\entry{prefix, type}{10}{prefix, type}
\entry{type prefix}{10}{type prefix}
\entry{default stack of a type prefix}{10}{default stack of a type prefix}
\entry{stack definition}{11}{stack definition}
\entry{defining a stack}{11}{defining a stack}
\entry{stack basic type}{11}{stack basic type}
\entry{basic type of a stack}{11}{basic type of a stack}
\entry{type of a stack, basic}{11}{type of a stack, basic}
\entry{stack prefix}{11}{stack prefix}
\entry{prefix, stack}{11}{prefix, stack}
\entry{instruction stream}{11}{instruction stream}
\entry{stack access, explicit}{11}{stack access, explicit}
\entry{Stack pointer access}{11}{Stack pointer access}
\entry{explicit stack access}{11}{explicit stack access}
\entry{macros recognized by Vmgen}{12}{macros recognized by Vmgen}
\entry{basic block, VM level}{12}{basic block, VM level}
\entry{C code restrictions}{13}{C code restrictions}
\entry{restrictions on C code}{13}{restrictions on C code}
\entry{assumptions about C code}{13}{assumptions about C code}
\entry{accessing stack (pointer)}{13}{accessing stack (pointer)}
\entry{stack pointer, access}{13}{stack pointer, access}
\entry{instruction pointer, access}{13}{instruction pointer, access}
\entry{stack caching, restriction on C code}{13}{stack caching, restriction on C code}
\entry{superinstructions, restrictions on components}{13}{superinstructions, restrictions on components}
\entry{stack growth direction}{13}{stack growth direction}
\entry{stack-access-transform}{13}{\code {stack-access-transform}}
\entry{superinstructions, defining}{14}{superinstructions, defining}
\entry{defining superinstructions}{14}{defining superinstructions}
\entry{prefixes of superinstructions}{14}{prefixes of superinstructions}
\entry{include-skipped-insts}{14}{include-skipped-insts}
\entry{store optimization}{15}{store optimization}
\entry{optimization, stack stores}{15}{optimization, stack stores}
\entry{stack stores, optimization}{15}{stack stores, optimization}
\entry{eliminating stack stores}{15}{eliminating stack stores}
\entry{Register VM}{15}{Register VM}
\entry{Superinstructions for register VMs}{15}{Superinstructions for register VMs}
\entry{tracing of register VMs}{15}{tracing of register VMs}
\entry{error messages}{17}{error messages}
\entry{# can only be on the input side error}{17}{\code {# can only be on the input side} error}
\entry{prefix for this combination must be defined earlier error}{17}{\code {prefix for this combination must be defined earlier} error}
\entry{sync line syntax error}{17}{\code {sync line syntax} error}
\entry{syntax error, wrong char error}{17}{\code {syntax error, wrong char} error}
\entry{too many stacks error}{17}{\code {too many stacks} error}
\entry{unknown prefix error}{17}{\code {unknown prefix} error}
\entry{unknown primitive error}{17}{\code {unknown primitive} error}
\entry{generated code, usage}{18}{generated code, usage}
\entry{Using vmgen-erated code}{18}{Using vmgen-erated code}
\entry{VM instruction execution}{18}{VM instruction execution}
\entry{engine}{18}{engine}
\entry{executing VM code}{18}{executing VM code}
\entry{engine.c}{18}{\file {engine.c}}
\entry{-vm.i output file}{18}{\file {-vm.i} output file}
\entry{tracing VM code}{18}{tracing VM code}
\entry{superinstructions and tracing}{18}{superinstructions and tracing}
\entry{type cast macro}{19}{type cast macro}
\entry{instruction stream, basic type}{19}{instruction stream, basic type}
\entry{unions in type cast macros}{19}{unions in type cast macros}
\entry{casts in type cast macros}{19}{casts in type cast macros}
\entry{type casting between floats and integers}{19}{type casting between floats and integers}
\entry{stack pointer definition}{20}{stack pointer definition}
\entry{instruction pointer definition}{20}{instruction pointer definition}
\entry{IMM_ARG}{20}{IMM_ARG}
\entry{top of stack caching}{20}{top of stack caching}
\entry{stack caching}{20}{stack caching}
\entry{TOS}{20}{TOS}
\entry{instruction table}{21}{instruction table}
\entry{opcode definition}{21}{opcode definition}
\entry{labels for threaded code}{21}{labels for threaded code}
\entry{vm_prim, definition}{21}{\code {vm_prim}, definition}
\entry{-labels.i output file}{21}{\file {-labels.i} output file}
\entry{VM code generation}{21}{VM code generation}
\entry{code generation, VM}{21}{code generation, VM}
\entry{-gen.i output file}{21}{\file {-gen.i} output file}
\entry{immediate arguments, VM code generation}{21}{immediate arguments, VM code generation}
\entry{vm_prim, use}{22}{\code {vm_prim}, use}
\entry{peephole optimization}{22}{peephole optimization}
\entry{superinstructions, generating}{22}{superinstructions, generating}
\entry{peephole.c}{22}{\file {peephole.c}}
\entry{-peephole.i output file}{22}{\file {-peephole.i} output file}
\entry{VM disassembler}{23}{VM disassembler}
\entry{disassembler, VM code}{23}{disassembler, VM code}
\entry{disasm.c}{23}{\file {disasm.c}}
\entry{-disasm.i output file}{23}{\file {-disasm.i} output file}
\entry{IP, IPTOS in disassmbler}{23}{\code {IP}, \code {IPTOS} in disassmbler}
\entry{VM profiler}{23}{VM profiler}
\entry{profiling for selecting superinstructions}{23}{profiling for selecting superinstructions}
\entry{superinstructions and profiling}{23}{superinstructions and profiling}
\entry{profile.c}{23}{\file {profile.c}}
\entry{-profile.i output file}{23}{\file {-profile.i} output file}
\entry{stat.awk}{23}{\file {stat.awk}}
\entry{seq2rule.awk}{23}{\file {seq2rule.awk}}
\entry{SUPER_END in profiling}{24}{\code {SUPER_END} in profiling}
\entry{BB_BOUNDARY in profiling}{24}{\code {BB_BOUNDARY} in profiling}
\entry{VM_IS_INST in profiling}{24}{\code {VM_IS_INST} in profiling}
\entry{hints}{25}{hints}
\entry{future ideas}{26}{future ideas}
\entry{Changes from old versions}{27}{Changes from old versions}
\entry{TAIL;, changes}{27}{\code {TAIL;}, changes}
\entry{vm_A2B, changes}{27}{\code {vm_\var {A}2\var {B}}, changes}
\entry{vm_twoA2B, changes}{27}{\code {vm_two\var {A}2\var {B}}, changes}
\entry{FDL, GNU Free Documentation License}{29}{FDL, GNU Free Documentation License}
