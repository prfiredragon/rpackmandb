use pickledb::{PickleDb, PickleDbDumpPolicy, SerializationMethod};
use clap::{Args, Parser, Subcommand};
use std::path::Path;

const VERSION: &str = "0.1.0";
const DBNAME: &str = "rpackmandb.db";

#[derive(Parser)]
#[command(version, about, long_about = None)]
#[command(propagate_version = true)]
struct Cli {
    #[command(subcommand)]
    command: Commands,

    #[arg(short, long)]
    ///aplication name
    name: Option<String>,

    #[arg(short, long)]
    ///aplication version
    apversion: Option<String>,

    #[arg(short, long)]
    ///download url
    url: Option<String>,

    #[arg(short, long)]
    ///install script url
    scripturl: Option<String>,

    #[arg(short, long)]
    ///Create a new DB
    dbnew: bool,

}

#[derive(Subcommand)]
enum Commands {
    /// Select install type
    Install(InstallArgs),
}

#[derive(Args)]
struct InstallArgs {
    #[clap(value_enum)]    
    install: InstallType,
}

#[derive(clap::ValueEnum, Clone, Debug)]
enum InstallType {
   Source,
   Fromsource,
   Bin,
}

fn create_db(db_name: &str) -> PickleDb{
    let mut new_db = PickleDb::new(
        db_name,
        PickleDbDumpPolicy::AutoDump,
        SerializationMethod::Json,
    );
    return new_db;
}

fn load_db(db_name: &str) -> PickleDb{
    let mut db = PickleDb::load(
        db_name,
        PickleDbDumpPolicy::AutoDump,
        SerializationMethod::Json,
    )
    .unwrap();
    return db;
}

fn main() {
    let cli = Cli::parse();
    println!("RPackMan Version {}", VERSION);

    // You can check for the existence of subcommands, and if found use their
    // matches just as you would the top level cmd
    match &cli.command {
        Commands::Install(source) => {
            println!("Install {:?} {:?} {:?}",cli.name, cli.apversion, source.install)
        },
    }
    if cli.dbnew {
        let mut db = create_db(DBNAME);
    }else{
        let mut db = load_db(DBNAME);
    }
    println!("filename {:?} of {:?}",getfilename("https://www.nano-editor.org/dist/v7/nano-7.2.tar.xz"), "https://www.nano-editor.org/dist/v7/nano-7.2.tar.xz")
}

fn getfilename(fullpath: &str) -> &str{
    let path = Path::new(fullpath);
    let filename = path.file_name().unwrap();

    println!("{}", filename.to_str().unwrap());
    return filename.to_str().unwrap();
}

fn concat_str(a: &str, b: &str) -> String {
    let owned_string: String = a.to_string().to_owned();
    let borrowed_string: &str = b;
    let together = owned_string.clone() + borrowed_string;
    return together;
}

fn concat_string(a: String, b: String) -> String {
    let ret = a + &b;
    return ret;
}