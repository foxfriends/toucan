use ethers_solc::{Project, ProjectPathsConfig};
use std::path::PathBuf;

fn main() {
    let root: PathBuf = env!("CARGO_MANIFEST_DIR").parse().unwrap();
    let project = Project::builder()
        .paths(ProjectPathsConfig::hardhat(root).unwrap())
        .build()
        .unwrap();
    project.compile().unwrap();
    project.rerun_if_sources_changed();
}
