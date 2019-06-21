import Foundation
import SPMUtility

let arguments = Array(ProcessInfo.processInfo.arguments.dropFirst())

// clerk <file.abi> <method> <arg0> <arg1> <arg2> [--json|--text|?]
// clerk <file.sol> --solc
// clerk

// Two argument parsers: one for .abi, one for .sol. Absorb remaining args in a vararg.
// .sol -> .abi
// Parse ABI to contract objects.
// Provide a contract object --> ArgumentParser conversion.
// Pull argument parser and fire args into it.

let solidityParser = ArgumentParser(usage: "<options>" overview: "run contract methods given a .sol file")
let solArgument = parser.add(positional: "contract",
                             kind: PathArgument.self,
                             usage: "Invokes",
                             completion: PathArgument.completion)

let parser = ArgumentParser(usage: "<options>", overview: "run contract methods")
let fileArgument = parser.add(positional: "contract",
                              kind: PathArgument.self,
                              usage: "Invokes",
                              completion: PathArgument.completion)
// let adapterArgument = parser.add(option: "--adapter", shortName: "-a", kind: AdapterArgument.self, usage: "Specify the adapter to use; defaults to repl", completion: AdapterArgument.completion)

do {
    let parsed = try parser.parse(arguments)
    let file = parsed.get(fileArgument)!
    print(file)
    //let adapter = parsed.get(adapterArgument) ?? AdapterArgument.repl
    //var bot = adapter.bot(named: "Gordias")

    //try addHelp(toBot: bot)
    //try addImgflip(toBot: &bot)

    //bot.listen()
} catch let ape as ArgumentParserError {

    default:
        FileHandle.standardError.write(String(describing: ape).data(using: .utf8)!)
    }
}
