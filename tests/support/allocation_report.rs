//! Native allocator report fields are bytes; RSS is KiB and covers the process.
#[derive(Debug, PartialEq)]
pub struct AllocationReport {
    pub allocated: u128,
    pub released: u128,
    pub live: usize,
    pub peak_live: usize,
    pub heap_extent: usize,
    pub rss_kib: usize,
}

pub fn parse(stderr: &str) -> Result<AllocationReport, String> {
    let line = stderr
        .trim_end_matches(['\r', '\n'])
        .strip_prefix("fwp allocation: ")
        .ok_or("missing allocation report")?;
    let fields: Vec<_> = line.split(", ").collect();
    let [allocated, released, live, peak, extent, rss] = fields.as_slice() else {
        return Err("allocation report requires six fields".into());
    };
    fn number<T: std::str::FromStr>(field: &str, unit: &str) -> Result<T, String> {
        let value = field
            .strip_suffix(unit)
            .ok_or_else(|| format!("expected {unit}: {field}"))?;
        if value.is_empty() || !value.bytes().all(|byte| byte.is_ascii_digit()) {
            return Err(format!("expected nonnegative integer: {field}"));
        }
        value
            .parse()
            .map_err(|_| format!("allocation report number out of range: {field}"))
    }
    Ok(AllocationReport {
        allocated: number(allocated, " bytes allocated")?,
        released: number(released, " bytes released")?,
        live: number(live, " live bytes")?,
        peak_live: number(peak, " peak live bytes")?,
        heap_extent: number(extent, " heap extent bytes")?,
        rss_kib: number(
            rss.strip_prefix("max RSS ").ok_or("missing RSS field")?,
            " KiB",
        )?,
    })
}
