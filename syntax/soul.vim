" SOUL syntax file
" Language: SOUL - http://soul.dev/
" Creator: Griffin Moe <me@griffin.moe>
" Homepage: http://github.com/gmoe/vim-soul
" Version: 0.9.55

if exists("b:current_syntax")
  finish
endif

syn clear

" Comments ----------------
syntax keyword soulCommentTodo contained TODO FIXME XXX TBD NOTE
syn region soulComment start=+//+ end=/$/ contains=soulCommentTodo
syn region soulComment start="/\*" end="\*/" fold keepend extend contains=soulCommentTodo,@Spell

" Primitives --------------
syn match soulNumber "\<[0-9][0-9_]*\%(i\%(32\|64\)\|L\)\=" display
syn match soulHexNumber "\<0x[a-fA-F0-9_]\+\%(i\%(32\|64\)\|L\)\=" display
syn match soulBinaryNumber "\<0b[01_]\+\%(i\%(32\|64\)\|L\)\=" display
syn match soulFloat "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\(f32\|f64\|f\)\=" display
syn keyword soulBoolean true false

syn match soulEscapeError /\\./ display contained containedin=soulString
syn match soulEscape /\\\([nrt0\\'"]\|x\x\{2}\)/ display contained containedin=soulString
syn match soulEscapeUnicode "\\\(x\x\+\|\o\{1,3}\|.\|$\)" display contained containedin=soulString
syn region soulString start=+"+ skip=+\\\\\|\\"+ end=+"+ keepend contains=@Spell,soulEscapeError,soulEscape,soulEscapeUnicode

syn match soulScalarType /\<[A-Za-z0-9_]\+\%(32\|64\)\=\%(\[\d\+\]\|<\d\+>\)\>/ contains=soulVariableType nextgroup=soulIdentifier skipwhite skipempty transparent
syn keyword soulVariableType void int int32 int64 float float32 float64 bool string nextgroup=soulIdentifier,soulProcessorLifecycleKeyword skipwhite skipempty

syn match soulRangeConstraint /\<\%(wrap\|clamp\)<.\+>/ contains=soulNumber,soulRangeConstraintStart,soulRangeConstraintEnd
syn match soulRangeConstraintStart /\<\%(wrap\|clamp\)</ contained nextgroup=soulRangeConstraintEnd containedin=soulRangeConstraint
syn match soulRangeConstraintEnd />/ contained containedin=soulRangeConstraint

" Constructs -------------
syn match soulIdentifier /\<[A-Za-z0-9_]\+\>/ display contained
syn keyword soulStruct struct nextgroup=soulIdentifier skipwhite skipempty

syn keyword soulKeyword let var nextgroup=soulIdentifier skipwhite skipempty
syn keyword soulKeyword external using return
syn keyword soulStorage const nextgroup=soulVariableType

syn keyword soulRepeat while for loop
syn keyword soulConditional if

" Preproc ---------------
syn keyword soulPreProc namespace input output graph event

syn match soulNamespace /\<[A-Za-z0-9_]\+::/
syn match soulNamespaceAnterior /\<[A-Za-z0-9_]\+/ display contained containedin=soulNamespace

syn region soulProcessor start=/processor\_.\+{/ skip=+{\_.\+}+ end=+}+ keepend extend transparent
syn match soulProcessorLifecycle /<\%(init\|advance\|run\)\s\*()/ display contained transparent containedin=soulProcessor contains=soulProcessorLifecycleKeyword
syn keyword soulProcessorLifecycleKeyword init advance run contained containedin=soulProcessorLifecycle
syn keyword soulPreProc processor contained containedin=soulProcessor

" Metafunctions ---------
syn keyword soulMetafunction type size elementType primitiveType isStruct isArray isDynamicArray isFixedSizeArray isVector isPrimitive isFloat isFloat32 isFloat64 isInt isInt32 isInt64 isScalar isString isBool isReference isConst static_assert

syn match soulTestCommand /##\s\+\%(global\|compile\|function\|disabled\|error\|processor\)/

let b:current_syntax = "soul"

hi link soulComment Comment
hi link soulCommentTodo Todo

hi link soulKeyword Keyword
hi link soulStorage StorageClass
hi link soulVariableType Type
hi link soulRangeConstraintStart Type
hi link soulRangeConstraintEnd Type

hi link soulEscape Special
hi link soulEscapeUnicode Special
hi link soulEscapeError Error
hi link soulString String

hi link soulNumber Number
hi link soulHexNumber Number
hi link soulBinaryNumber Number
hi link soulFloat Float
hi link soulBoolean Boolean

hi link soulStruct Keyword

hi link soulConditional Conditional
hi link soulRepeat Conditional

hi link soulPreProc PreProc
hi link soulNamespaceAnterior Identifier

hi link soulProcessorLifecycleKeyword Special

hi link soulMetafunction Macro
hi link soulTestCommand Macro
