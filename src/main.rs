use pickledb::{PickleDb, PickleDbDumpPolicy, SerializationMethod};
use clap::{Args, Parser, Subcommand};
use std::path::Path;
use std::fs;
use std::str::FromStr;

#[macro_use]
extern crate version;

mod dbman;
use dbman::dbman::{init_db, search_db};

const VERSION: &str = "0.1.0";
const DBNAME: &str = "/system/packages/rpackman/share/rpackman/data/rpackmandb/rpackmandb.db";
const CUSTOMDBPATH: &str = "/system/packages/rpackman/share/rpackman/data/";

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

    #[arg(long)]
    ///Create a new custom DB
    newdb: Option<String>,

    #[arg(short, long)]
    ///Use custom DB
    db: Option<String>,

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
    let new_db = PickleDb::new(
        db_name,
        PickleDbDumpPolicy::AutoDump,
        SerializationMethod::Json,
    );
    return new_db;
}

fn load_db(db_name: &str) -> PickleDb{
    let db = PickleDb::load(
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
    if let Some(dbnew) = cli.newdb.as_deref() {
        let customdbfullname = create_custom_path(cli.newdb.as_deref().unwrap());  
        let db = create_db(customdbfullname.as_str());
    }else if let Some(dbnew) = cli.db.as_deref() {
        let customdbfullname = to_custom_path(cli.db.as_deref().unwrap());  
        let db = load_db(customdbfullname.as_str());
    }else{
        let db = load_db(DBNAME);
    }
    println!("filename {:?} of {:?}",getfilename("https://www.nano-editor.org/dist/v7/nano-7.2.tar.xz"), "https://www.nano-editor.org/dist/v7/nano-7.2.tar.xz")
}
fn to_custom_path(custom_name: &str) -> String{
    let path_a = concat_str(CUSTOMDBPATH, custom_name);
    let path_b = concat_str(path_a.as_str(), "/");
    let path_c = concat_str(path_b.as_str(), custom_name);
    let path_d = concat_str(&path_c.as_str(), ".db");
    return path_d;
}
fn create_custom_path(custom_name: &str) -> String{
    let path_a = concat_str(CUSTOMDBPATH, custom_name);
    let path_b = concat_str(path_a.as_str(), "/");
    let path_c = concat_str(path_b.as_str(), custom_name);
    let path_d = concat_str(&path_c.as_str(), ".db");
    let ret = create_path(&path_a);
    if ret.is_ok() {
        return path_d;
    }else{
        let noret: String =  String::from_str("").unwrap();
        return noret;
    }
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

fn create_path(to_path: &str) -> std::io::Result<()> {
    fs::create_dir_all(to_path)?;
    Ok(())
}
