import json, subprocess
from pathlib import Path
HEAD="1aadb8a075e1737d0e6a4db96eae5d675f6fb404"
BASE="b4285fc177b3ae7afaf195e5ebd7115cc77b815c"
SUBJECT="Own resource and State lifetimes and preserve inferred effects"
assert len(SUBJECT)<=80 and "\n" not in SUBJECT
NAMES={"test","bench","macos (macos-15)","macos (macos-15-intel)","macos_gc (macos-15)","macos_gc (macos-15-intel)"}
def command(*args):return subprocess.check_output(list(args),text=True)
def run(number):return json.loads(command("gh","run","view",str(number),"--json","headSha,status,conclusion,jobs"))
ci=run(38174221614);docs=run(38174221611)
for gate in [ci,docs]:
 assert gate["headSha"]==HEAD and gate["status"]=="completed" and gate["conclusion"]=="success",gate
assert {j["name"] for j in ci["jobs"]}==NAMES
assert len(ci["jobs"])==6
assert all(j["status"]=="completed" and j["conclusion"]=="success" for j in ci["jobs"])
assert len(docs["jobs"])==1 and docs["jobs"][0]["name"]=="roadmap_docs"
assert docs["jobs"][0]["status"]=="completed" and docs["jobs"][0]["conclusion"]=="success"
pr=json.loads(command("gh","pr","view","124","--json","number,state,isDraft,headRefOid,baseRefOid,url"))
assert pr["state"] in {"OPEN","MERGED"} and not pr["isDraft"] and pr["headRefOid"]==HEAD and pr["baseRefOid"]==BASE,pr
Path("/private/tmp/fwp-pr124-final-gate-proof.json").write_text(json.dumps(dict(pr=pr,ci=ci,docs=docs),indent=2)+"\n")
if pr["state"]=="OPEN":
 subprocess.run(["gh","pr","merge","124","--squash","--subject",SUBJECT,"--body","","--match-head-commit",HEAD],check=True)
post=json.loads(command("gh","api","repos/e6qu/fun-with-pipes/pulls/124"))
assert post["merged"] and post["merged_at"] and post["merge_commit_sha"]
assert all(j["completedAt"]<=post["merged_at"] for gate in [ci,docs] for j in gate["jobs"])
Path("/private/tmp/fwp-pr124-postmerge.json").write_text(json.dumps(post,indent=2)+"\n")
print("Merged PR124 as",post["merge_commit_sha"],"at",post["merged_at"],flush=True)
