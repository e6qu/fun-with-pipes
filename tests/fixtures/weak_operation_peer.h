#ifndef FWP_WEAK_OPERATION_PEER_H
#define FWP_WEAK_OPERATION_PEER_H
#include <stdint.h>

#if REFERENCE_FWP == 1
typedef uint64_t ReferenceOwner;
typedef uint64_t ReferenceWeak;
#else
typedef struct ReferenceTarget *ReferenceOwner;
typedef struct ReferenceControl *ReferenceWeak;
#endif

ReferenceOwner reference_make(int64_t input);
ReferenceWeak reference_downgrade(ReferenceOwner owner);
int reference_lookup(ReferenceWeak weak);
void reference_release_owner(ReferenceOwner owner);
void reference_release_weak(ReferenceWeak weak);
int reference_observe(int argc, char **argv);
#if REFERENCE_DIAGNOSTIC == 1
int reference_clean(void);
#endif
#endif
