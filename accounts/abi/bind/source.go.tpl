// Code generated - DO NOT EDIT.
// This file is a generated binding and any manual changes will be lost.

package {{.Package}}

import (
	"encoding/hex"
	"github.com/go-errors/errors"
	"gitlab.com/due/common/types"
	"gitlab.com/due/common/due_eth"
	"gitlab.com/due/common/due_eth/due_abi"
	"strings"

	ethereum "github.com/ethereum/go-ethereum"
	"github.com/ethereum/go-ethereum/accounts/abi"
	"github.com/ethereum/go-ethereum/accounts/abi/bind"
	ethTypes "github.com/ethereum/go-ethereum/core/types"
	"github.com/ethereum/go-ethereum/event"
)

// Reference imports to suppress errors if they are not otherwise used.
var (
  _ = due_abi.ToABIForm
  _ = due_eth.WatchEvent[any]
  _ = hex.DecodeString
	_ = errors.New
	_ = strings.NewReader
	_ = ethereum.NotFound
	_ = bind.Bind
	_ = event.NewSubscription
	_ = abi.ConvertType
)

{{$structs := .Structs}}
{{range $structs}}
	// {{.Name}} is an auto generated low-level Go binding around an user-defined struct.
	type {{.Name}} struct {
	{{range $field := .Fields}}
	{{$field.Name}} {{$field.Type}}{{end}}
	}
{{end}}

{{range $contract := .Contracts}}
	// {{.Type}}MetaData contains all meta data concerning the {{.Type}} contract.
	var {{.Type}}MetaData = &bind.MetaData{
		ABI: "{{.InputABI}}",
		{{if $contract.FuncSigs -}}
		Sigs: map[string]string{
			{{range $strsig, $binsig := .FuncSigs}}"{{$binsig}}": "{{$strsig}}",
			{{end}}
		},
		{{end -}}
		{{if .InputBin -}}
		Bin: "0x{{.InputBin}}",
		{{end}}
	}
	// {{.Type}}ABI is the input ABI used to generate the binding from.
	// Deprecated: Use {{.Type}}MetaData.ABI instead.
	var {{.Type}}ABI = {{.Type}}MetaData.ABI

	{{if $contract.FuncSigs}}
		// Deprecated: Use {{.Type}}MetaData.Sigs instead.
		// {{.Type}}FuncSigs maps the 4-byte function signature to its string representation.
		var {{.Type}}FuncSigs = {{.Type}}MetaData.Sigs
	{{end}}

	{{if .InputBin}}
		// {{.Type}}Bin is the compiled bytecode used for deploying new contracts.
		// Deprecated: Use {{.Type}}MetaData.Bin instead.
		var {{.Type}}Bin = {{.Type}}MetaData.Bin

		// Deploy{{.Type}} deploys a new Ethereum contract, binding an instance of {{.Type}} to it.
		func Deploy{{.Type}}(auth *bind.TransactOpts, backend bind.ContractBackend {{range .Constructor.Inputs}}, {{.Name}} {{bindtype .Type $structs}}{{end}}) (types.EvmAddress, *ethTypes.Transaction, *{{.Type}}, error) {
		  parsed, err := {{.Type}}MetaData.GetAbi()
		  if err != nil {
		    return types.EvmAddress{}, nil, nil, errors.Wrap(err, 0)
		  }
		  if parsed == nil {
			return types.EvmAddress{}, nil, nil, errors.New("GetABI returned nil")
		  }
		  {{range $pattern, $name := .Libraries}}
			{{decapitalise $name}}Addr, _, _, _ := Deploy{{capitalise $name}}(auth, backend)
			{{$contract.Type}}Bin = strings.ReplaceAll({{$contract.Type}}Bin, "__${{$pattern}}$__", {{decapitalise $name}}Addr.String()[2:])
		  {{end}}

		  bytecode, err := hex.DecodeString({{.Type}}Bin[2:])
		  if err != nil {
		    return types.EvmAddress{}, nil, nil, errors.Wrap(err, 0)
		  }
		  address, tx, contract, err := bind.DeployContract(auth, *parsed, bytecode, backend {{range .Constructor.Inputs}}, {{.Name}}{{end}})
		  if err != nil {
		    return types.EvmAddress{}, nil, nil, errors.Wrap(err, 0)
		  }
		  return (types.EvmAddress)(address), tx, &{{.Type}}{
		    {{.Type}}Caller: {{.Type}}Caller{contract: contract},
		    {{.Type}}Transactor: {{.Type}}Transactor{contract: contract},
		    {{.Type}}Filterer: {{.Type}}Filterer{contract: contract},
		    Populate: {{.Type}}Populator{abi: parsed},
		    CallStatic: {{.Type}}StaticCaller{contract: contract},
      }, nil
		}

	func (_{{$contract.Type}} *{{$contract.Type}}Populator) Deploy({{range $i, $_ := .Constructor.Inputs}}{{if ne $i 0}},{{end}} {{.Name}} {{bindtype .Type $structs}} {{end}}) ([]byte, error) {
		{{range $pattern, $name := .Libraries}}
		{{decapitalise $name}}Addr, _, _, _ := Deploy{{capitalise $name}}(auth, backend)
		{{$contract.Type}}Bin = strings.ReplaceAll({{$contract.Type}}Bin, "__${{$pattern}}$__", {{decapitalise $name}}Addr.String()[2:])
		{{end}}
		bytecode, err := hex.DecodeString({{.Type}}Bin[2:])

		if err != nil {
			return nil, errors.Wrap(err, 0)
		}

		input, err := _{{$contract.Type}}.Constructor({{range $i, $_ := .Constructor.Inputs}}{{if ne $i 0}},{{end}} {{.Name}}{{end}})

		if err != nil {
			return nil, errors.Wrap(err, 0)
		}

		return append(bytecode, input...), nil
	}

	func (_{{$contract.Type}} *{{$contract.Type}}Populator) Constructor({{range $i, $_ := .Constructor.Inputs}}{{if ne $i 0}},{{end}} {{.Name}} {{bindtype .Type $structs}} {{end}}) ([]byte, error) {
		return _{{$contract.Type}}.abi.Pack(""{{range .Constructor.Inputs}}, due_abi.ToABIForm({{.Name}}){{end}})
	}
	{{end}}

	// {{.Type}} is an auto generated Go binding around an Ethereum contract.
	type {{.Type}} struct {
	  {{.Type}}Caller     // Read-only binding to the contract
	  {{.Type}}Transactor // Write-only binding to the contract
	  {{.Type}}Filterer   // Log filterer for contract events
	  Populate {{.Type}}Populator
	  CallStatic {{.Type}}StaticCaller
	}

	// {{.Type}}Caller is an auto generated read-only Go binding around an Ethereum contract.
	type {{.Type}}Caller struct {
	  contract *bind.BoundContract // Generic contract wrapper for the low level calls
	}

	// {{.Type}}Transactor is an auto generated write-only Go binding around an Ethereum contract.
	type {{.Type}}Transactor struct {
	  contract *bind.BoundContract // Generic contract wrapper for the low level calls
	}

	// {{.Type}}Transactor is an auto generated write-only Go binding around an Ethereum contract.
	type {{.Type}}Populator struct {
	  abi *abi.ABI
	}

	// {{.Type}}Transactor is an auto generated write-only Go binding around an Ethereum contract.
	type {{.Type}}StaticCaller struct {
	  contract *bind.BoundContract // Generic contract wrapper for the low level calls
	}

	// {{.Type}}Filterer is an auto generated log filtering Go binding around an Ethereum contract events.
	type {{.Type}}Filterer struct {
	  contract *bind.BoundContract // Generic contract wrapper for the low level calls
	}

	// {{.Type}}Session is an auto generated Go binding around an Ethereum contract,
	// with pre-set call and transact options.
	type {{.Type}}Session struct {
	  Contract     *{{.Type}}        // Generic contract binding to set the session for
	  CallOpts     bind.CallOpts     // Call options to use throughout this session
	  TransactOpts bind.TransactOpts // Transaction auth options to use throughout this session
	}

	// {{.Type}}CallerSession is an auto generated read-only Go binding around an Ethereum contract,
	// with pre-set call options.
	type {{.Type}}CallerSession struct {
	  Contract *{{.Type}}Caller // Generic contract caller binding to set the session for
	  CallOpts bind.CallOpts    // Call options to use throughout this session
	}

	// {{.Type}}TransactorSession is an auto generated write-only Go binding around an Ethereum contract,
	// with pre-set transact options.
	type {{.Type}}TransactorSession struct {
	  Contract     *{{.Type}}Transactor // Generic contract transactor binding to set the session for
	  TransactOpts bind.TransactOpts    // Transaction auth options to use throughout this session
	}

	// {{.Type}}Raw is an auto generated low-level Go binding around an Ethereum contract.
	type {{.Type}}Raw struct {
	  Contract *{{.Type}} // Generic contract binding to access the raw methods on
	}

	// {{.Type}}CallerRaw is an auto generated low-level read-only Go binding around an Ethereum contract.
	type {{.Type}}CallerRaw struct {
		Contract *{{.Type}}Caller // Generic read-only contract binding to access the raw methods on
	}

	// {{.Type}}TransactorRaw is an auto generated low-level write-only Go binding around an Ethereum contract.
	type {{.Type}}TransactorRaw struct {
		Contract *{{.Type}}Transactor // Generic write-only contract binding to access the raw methods on
	}

	// New{{.Type}} creates a new instance of {{.Type}}, bound to a specific deployed contract.
	func New{{.Type}}(address types.EvmAddress, backend bind.ContractBackend) (*{{.Type}}, error) {
	  contract, err := bind{{.Type}}(address.Bytes20(), backend, backend, backend)
	  if err != nil {
	    return nil, errors.Wrap(err, 0)
	  }
	  parsed, err := {{.Type}}MetaData.GetAbi()
    if err != nil {
      return nil, errors.Wrap(err, 0)
    }
	  return &{{.Type}}{
	    {{.Type}}Caller: {{.Type}}Caller{contract: contract},
	    {{.Type}}Transactor: {{.Type}}Transactor{contract: contract},
	    {{.Type}}Filterer: {{.Type}}Filterer{contract: contract},
      Populate: {{.Type}}Populator{abi: parsed},
      CallStatic: {{.Type}}StaticCaller{contract: contract},
	  }, nil
	}

	// New{{.Type}}Caller creates a new read-only instance of {{.Type}}, bound to a specific deployed contract.
	func New{{.Type}}Caller(address types.EvmAddress, caller bind.ContractCaller) (*{{.Type}}Caller, error) {
	  contract, err := bind{{.Type}}(address.Bytes20(), caller, nil, nil)
	  if err != nil {
	    return nil, errors.Wrap(err, 0)
	  }
	  return &{{.Type}}Caller{contract: contract}, nil
	}

	// New{{.Type}}Transactor creates a new write-only instance of {{.Type}}, bound to a specific deployed contract.
	func New{{.Type}}Transactor(address types.EvmAddress, transactor bind.ContractTransactor) (*{{.Type}}Transactor, error) {
	  contract, err := bind{{.Type}}(address.Bytes20(), nil, transactor, nil)
	  if err != nil {
	    return nil, errors.Wrap(err, 0)
	  }
	  return &{{.Type}}Transactor{contract: contract}, nil
	}

	// New{{.Type}}Filterer creates a new log filterer instance of {{.Type}}, bound to a specific deployed contract.
 	func New{{.Type}}Filterer(address types.EvmAddress, filterer bind.ContractFilterer) (*{{.Type}}Filterer, error) {
 	  contract, err := bind{{.Type}}(address.Bytes20(), nil, nil, filterer)
 	  if err != nil {
 	    return nil, errors.Wrap(err, 0)
 	  }
 	  return &{{.Type}}Filterer{contract: contract}, nil
 	}

	// New{{.Type}}Filterer creates a new log filterer instance of {{.Type}}, bound to a specific deployed contract.
 	func New{{.Type}}Populator() (*{{.Type}}Populator, error) {
 	  parsed, err := {{.Type}}MetaData.GetAbi()

    if err != nil {
      return nil, errors.Wrap(err, 0)
    }

 	  return &{{.Type}}Populator{abi: parsed}, nil
 	}

	// bind{{.Type}} binds a generic wrapper to an already deployed contract.
	func bind{{.Type}}(address types.EvmAddress, caller bind.ContractCaller, transactor bind.ContractTransactor, filterer bind.ContractFilterer) (*bind.BoundContract, error) {
	  parsed, err := {{.Type}}MetaData.GetAbi()
	  if err != nil {
	    return nil, errors.Wrap(err, 0)
	  }
	  return bind.NewBoundContract(address.Bytes20(), *parsed, caller, transactor, filterer), nil
	}

	// Call invokes the (constant) contract method with params as input values and
	// sets the output to result. The result type might be a single field for simple
	// returns, a slice of interfaces for anonymous returns and a struct for named
	// returns.
	func (_{{$contract.Type}} *{{$contract.Type}}Raw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
		return _{{$contract.Type}}.Contract.{{$contract.Type}}Caller.contract.Call(opts, result, method, params...)
	}

	// Transfer initiates a plain transaction to move funds to the contract, calling
	// its default method if one is available.
	func (_{{$contract.Type}} *{{$contract.Type}}Raw) Transfer(opts *bind.TransactOpts) (*ethTypes.Transaction, error) {
		return _{{$contract.Type}}.Contract.{{$contract.Type}}Transactor.contract.Transfer(opts)
	}

	// Transact invokes the (paid) contract method with params as input values.
	func (_{{$contract.Type}} *{{$contract.Type}}Raw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*ethTypes.Transaction, error) {
		return _{{$contract.Type}}.Contract.{{$contract.Type}}Transactor.contract.Transact(opts, method, params...)
	}

	// Call invokes the (constant) contract method with params as input values and
	// sets the output to result. The result type might be a single field for simple
	// returns, a slice of interfaces for anonymous returns and a struct for named
	// returns.
	func (_{{$contract.Type}} *{{$contract.Type}}CallerRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
		return _{{$contract.Type}}.Contract.contract.Call(opts, result, method, params...)
	}

	// Transfer initiates a plain transaction to move funds to the contract, calling
	// its default method if one is available.
	func (_{{$contract.Type}} *{{$contract.Type}}TransactorRaw) Transfer(opts *bind.TransactOpts) (*ethTypes.Transaction, error) {
		return _{{$contract.Type}}.Contract.contract.Transfer(opts)
	}

	// Transact invokes the (paid) contract method with params as input values.
	func (_{{$contract.Type}} *{{$contract.Type}}TransactorRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*ethTypes.Transaction, error) {
		return _{{$contract.Type}}.Contract.contract.Transact(opts, method, params...)
	}

	{{range .Calls}}
		// {{.Normalized.Name}} is a free data retrieval call binding the contract method 0x{{printf "%x" .Original.ID}}.
		//
		// Solidity: {{.Original.String}}
		func (_{{$contract.Type}} *{{$contract.Type}}Caller) {{.Normalized.Name}}(opts *bind.CallOpts {{range .Normalized.Inputs}}, {{.Name}} {{bindtype .Type $structs}} {{end}}) ({{if .Structured}}struct{ {{range .Normalized.Outputs}}{{.Name}} {{bindtype .Type $structs}};{{end}} },{{else}}{{range .Normalized.Outputs}}{{bindtype .Type $structs}},{{end}}{{end}} error) {
			var out []interface{}
			err := _{{$contract.Type}}.contract.Call(opts, &out, "{{.Original.Name}}" {{range .Normalized.Inputs}}, due_abi.ToABIForm({{.Name}}){{end}})
			{{if .Structured}}
			outstruct := new(struct{ {{range .Normalized.Outputs}} {{.Name}} {{bindtype .Type $structs}}; {{end}} })
			if err != nil {
				return *outstruct, errors.Wrap(err, 0)
			}
			{{range $i, $t := .Normalized.Outputs}}
			outstruct.{{.Name}} = due_abi.FromABI[{{bindtype .Type $structs}}](out[{{$i}}]){{end}}

			return *outstruct, err
			{{else}}
			if err != nil {
				return {{range $i, $_ := .Normalized.Outputs}}*new({{bindtype .Type $structs}}), {{end}} err
			}
			{{range $i, $t := .Normalized.Outputs}}
			out{{$i}} := due_abi.FromABI[{{bindtype .Type $structs}}](out[{{$i}}]){{end}}

			return {{range $i, $t := .Normalized.Outputs}}out{{$i}}, {{end}} err
			{{end}}
		}

		// {{.Normalized.Name}} is a free data retrieval call binding the contract method 0x{{printf "%x" .Original.ID}}.
		//
		// Solidity: {{.Original.String}}
		func (_{{$contract.Type}} *{{$contract.Type}}Session) {{.Normalized.Name}}({{range $i, $_ := .Normalized.Inputs}}{{if ne $i 0}},{{end}} {{.Name}} {{bindtype .Type $structs}} {{end}}) ({{if .Structured}}struct{ {{range .Normalized.Outputs}}{{.Name}} {{bindtype .Type $structs}};{{end}} }, {{else}} {{range .Normalized.Outputs}}{{bindtype .Type $structs}},{{end}} {{end}} error) {
		  return _{{$contract.Type}}.Contract.{{.Normalized.Name}}(&_{{$contract.Type}}.CallOpts {{range .Normalized.Inputs}}, {{.Name}}{{end}})
		}

		// {{.Normalized.Name}} is a free data retrieval call binding the contract method 0x{{printf "%x" .Original.ID}}.
		//
		// Solidity: {{.Original.String}}
		func (_{{$contract.Type}} *{{$contract.Type}}CallerSession) {{.Normalized.Name}}({{range $i, $_ := .Normalized.Inputs}}{{if ne $i 0}},{{end}} {{.Name}} {{bindtype .Type $structs}} {{end}}) ({{if .Structured}}struct{ {{range .Normalized.Outputs}}{{.Name}} {{bindtype .Type $structs}};{{end}} }, {{else}} {{range .Normalized.Outputs}}{{bindtype .Type $structs}},{{end}} {{end}} error) {
		  return _{{$contract.Type}}.Contract.{{.Normalized.Name}}(&_{{$contract.Type}}.CallOpts {{range .Normalized.Inputs}}, {{.Name}}{{end}})
		}

		// {{.Normalized.Name}} is a paid mutator transaction binding the contract method 0x{{printf "%x" .Original.ID}}.
		//
		// Solidity: {{.Original.String}}
		func (_{{$contract.Type}} *{{$contract.Type}}Populator) {{.Normalized.Name}}({{range $i, $_ := .Normalized.Inputs}}{{if ne $i 0}},{{end}} {{.Name}} {{bindtype .Type $structs}} {{end}}) ([]byte, error) {
			return _{{$contract.Type}}.abi.Pack("{{.Original.Name}}" {{range .Normalized.Inputs}}, due_abi.ToABIForm({{.Name}}){{end}})
		}
	{{end}}

	{{range .Transacts}}
		// {{.Normalized.Name}} is a paid mutator transaction binding the contract method 0x{{printf "%x" .Original.ID}}.
		//
		// Solidity: {{.Original.String}}
		func (_{{$contract.Type}} *{{$contract.Type}}Transactor) {{.Normalized.Name}}(opts *bind.TransactOpts {{range .Normalized.Inputs}}, {{.Name}} {{bindtype .Type $structs}} {{end}}) (*ethTypes.Transaction, error) {
			return _{{$contract.Type}}.contract.Transact(opts, "{{.Original.Name}}" {{range .Normalized.Inputs}}, due_abi.ToABIForm({{.Name}}){{end}})
		}

		// {{.Normalized.Name}} is a paid mutator transaction binding the contract method 0x{{printf "%x" .Original.ID}}.
		//
		// Solidity: {{.Original.String}}
		func (_{{$contract.Type}} *{{$contract.Type}}Populator) {{.Normalized.Name}}({{range $i, $_ := .Normalized.Inputs}}{{if ne $i 0}},{{end}} {{.Name}} {{bindtype .Type $structs}} {{end}}) ([]byte, error) {
			return _{{$contract.Type}}.abi.Pack("{{.Original.Name}}" {{range .Normalized.Inputs}}, due_abi.ToABIForm({{.Name}}){{end}})
		}

		// {{.Normalized.Name}} is a paid mutator transaction binding the contract method 0x{{printf "%x" .Original.ID}}.
		//
		// Solidity: {{.Original.String}}
		func (_{{$contract.Type}} *{{$contract.Type}}StaticCaller) {{.Normalized.Name}}(opts *bind.CallOpts {{range .Normalized.Inputs}}, {{.Name}} {{bindtype .Type $structs}} {{end}}) ({{if .Structured}}struct{ {{range .Normalized.Outputs}}{{.Name}} {{bindtype .Type $structs}};{{end}} },{{else}}{{range .Normalized.Outputs}}{{bindtype .Type $structs}},{{end}}{{end}} error) {
      var out []interface{}
      err := _{{$contract.Type}}.contract.Call(opts, &out, "{{.Original.Name}}" {{range .Normalized.Inputs}}, due_abi.ToABIForm({{.Name}}){{end}})
      {{if .Structured}}
      outstruct := new(struct{ {{range .Normalized.Outputs}} {{.Name}} {{bindtype .Type $structs}}; {{end}} })
      if err != nil {
        return *outstruct, errors.Wrap(err, 0)
      }
      {{range $i, $t := .Normalized.Outputs}}
      outstruct.{{.Name}} = due_abi.FromABI[{{bindtype .Type $structs}}](out[{{$i}}]){{end}}

      return *outstruct, nil
      {{else}}
      if err != nil {
        return {{range $i, $_ := .Normalized.Outputs}}*new({{bindtype .Type $structs}}), {{end}} errors.Wrap(err, 0)
      }
      {{range $i, $t := .Normalized.Outputs}}
      out{{$i}} := due_abi.FromABI[{{bindtype .Type $structs}}](out[{{$i}}]){{end}}

      return {{range $i, $t := .Normalized.Outputs}}out{{$i}}, {{end}} nil
      {{end}}
    }

		// {{.Normalized.Name}} is a paid mutator transaction binding the contract method 0x{{printf "%x" .Original.ID}}.
		//
		// Solidity: {{.Original.String}}
		func (_{{$contract.Type}} *{{$contract.Type}}Session) {{.Normalized.Name}}({{range $i, $_ := .Normalized.Inputs}}{{if ne $i 0}},{{end}} {{.Name}} {{bindtype .Type $structs}} {{end}}) (*ethTypes.Transaction, error) {
		  return _{{$contract.Type}}.Contract.{{.Normalized.Name}}(&_{{$contract.Type}}.TransactOpts {{range $i, $_ := .Normalized.Inputs}}, {{.Name}}{{end}})
		}

		// {{.Normalized.Name}} is a paid mutator transaction binding the contract method 0x{{printf "%x" .Original.ID}}.
		//
		// Solidity: {{.Original.String}}
		func (_{{$contract.Type}} *{{$contract.Type}}TransactorSession) {{.Normalized.Name}}({{range $i, $_ := .Normalized.Inputs}}{{if ne $i 0}},{{end}} {{.Name}} {{bindtype .Type $structs}} {{end}}) (*ethTypes.Transaction, error) {
		  return _{{$contract.Type}}.Contract.{{.Normalized.Name}}(&_{{$contract.Type}}.TransactOpts {{range $i, $_ := .Normalized.Inputs}}, {{.Name}}{{end}})
		}
	{{end}}

	{{if .Fallback}}
		// Fallback is a paid mutator transaction binding the contract fallback function.
		//
		// Solidity: {{.Fallback.Original.String}}
		func (_{{$contract.Type}} *{{$contract.Type}}Transactor) Fallback(opts *bind.TransactOpts, calldata []byte) (*ethTypes.Transaction, error) {
			return _{{$contract.Type}}.contract.RawTransact(opts, calldata)
		}

		// Fallback is a paid mutator transaction binding the contract fallback function.
		//
		// Solidity: {{.Fallback.Original.String}}
		func (_{{$contract.Type}} *{{$contract.Type}}Session) Fallback(calldata []byte) (*ethTypes.Transaction, error) {
		  return _{{$contract.Type}}.Contract.Fallback(&_{{$contract.Type}}.TransactOpts, calldata)
		}

		// Fallback is a paid mutator transaction binding the contract fallback function.
		//
		// Solidity: {{.Fallback.Original.String}}
		func (_{{$contract.Type}} *{{$contract.Type}}TransactorSession) Fallback(calldata []byte) (*ethTypes.Transaction, error) {
		  return _{{$contract.Type}}.Contract.Fallback(&_{{$contract.Type}}.TransactOpts, calldata)
		}
	{{end}}

	{{if .Receive}}
		// Receive is a paid mutator transaction binding the contract receive function.
		//
		// Solidity: {{.Receive.Original.String}}
		func (_{{$contract.Type}} *{{$contract.Type}}Transactor) Receive(opts *bind.TransactOpts) (*ethTypes.Transaction, error) {
			return _{{$contract.Type}}.contract.RawTransact(opts, nil) // calldata is disallowed for receive function
		}

		// Receive is a paid mutator transaction binding the contract receive function.
		//
		// Solidity: {{.Receive.Original.String}}
		func (_{{$contract.Type}} *{{$contract.Type}}Session) Receive() (*ethTypes.Transaction, error) {
		  return _{{$contract.Type}}.Contract.Receive(&_{{$contract.Type}}.TransactOpts)
		}

		// Receive is a paid mutator transaction binding the contract receive function.
		//
		// Solidity: {{.Receive.Original.String}}
		func (_{{$contract.Type}} *{{$contract.Type}}TransactorSession) Receive() (*ethTypes.Transaction, error) {
		  return _{{$contract.Type}}.Contract.Receive(&_{{$contract.Type}}.TransactOpts)
		}
	{{end}}

	{{range .Events}}
		// {{$contract.Type}}{{.Normalized.Name}} represents a {{.Normalized.Name}} event raised by the {{$contract.Type}} contract.
		type {{$contract.Type}}{{.Normalized.Name}} struct { {{range .Normalized.Inputs}}
			{{capitalise .Name}} {{if .Indexed}}{{bindtopictype .Type $structs}}{{else}}{{bindtype .Type $structs}}{{end}}; {{end}}
			Raw ethTypes.Log // Blockchain specific contextual infos
		}

		// Filter{{.Normalized.Name}} is a free log retrieval operation binding the contract event 0x{{printf "%x" .Original.ID}}.
		//
		// Solidity: {{.Original.String}}
 		func (_{{$contract.Type}} *{{$contract.Type}}Filterer) Filter{{.Normalized.Name}}(opts *bind.FilterOpts{{range .Normalized.Inputs}}{{if .Indexed}}, {{.Name}} []{{bindtype .Type $structs}}{{end}}{{end}}) (*due_eth.EventIterator[{{$contract.Type}}{{.Normalized.Name}}], error) {
			return due_eth.NewEventIterator[{{$contract.Type}}{{.Normalized.Name}}](_{{$contract.Type}}.contract, opts, "{{.Original.Name}}"{{range .Normalized.Inputs}}{{if .Indexed}}, due_abi.ToQuery({{.Name}}){{end}}{{end}})
 		}

		// Watch{{.Normalized.Name}} is a free log subscription operation binding the contract event 0x{{printf "%x" .Original.ID}}.
		//
		// Solidity: {{.Original.String}}
		func (_{{$contract.Type}} *{{$contract.Type}}Filterer) Watch{{.Normalized.Name}}(opts *bind.WatchOpts, sink chan<- *{{$contract.Type}}{{.Normalized.Name}}{{range .Normalized.Inputs}}{{if .Indexed}}, {{.Name}} []{{bindtype .Type $structs}}{{end}}{{end}}) (event.Subscription, error) {
			return due_eth.WatchEvent[{{$contract.Type}}{{.Normalized.Name}}](_{{$contract.Type}}.contract, opts, sink, "{{.Original.Name}}"{{range .Normalized.Inputs}}{{if .Indexed}}, due_abi.ToQuery({{.Name}}){{end}}{{end}})
		}

		// Parse{{.Normalized.Name}} is a log parse operation binding the contract event 0x{{printf "%x" .Original.ID}}.
		//
		// Solidity: {{.Original.String}}
		func (_{{$contract.Type}} *{{$contract.Type}}Filterer) Parse{{.Normalized.Name}}(log ethTypes.Log) (*{{$contract.Type}}{{.Normalized.Name}}, error) {
			return due_abi.UnpackLogContract[{{$contract.Type}}{{.Normalized.Name}}](_{{$contract.Type}}.contract, "{{.Original.Name}}", log)
		}
 	{{end}}
{{end}}
