/* Deterministic OS-result peer: 80 unique IPv4 addresses, duplicates,
 * one IPv6 address and an unsupported family. One native allocation per call. */
static int dns_os_live;
struct dns_result {
    struct addrinfo entries[83];
    struct sockaddr_in ipv4[80];
    struct sockaddr_in6 ipv6;
};
static int dns_getaddrinfo(const char *host, const char *service,
                          const struct addrinfo *hints, struct addrinfo **out) {
    (void)host; (void)service; (void)hints;
    struct dns_result *r = calloc(1, sizeof *r);
    if (!r) abort();
    dns_os_live++;
    for (int i=0;i<83;i++) r->entries[i].ai_next = i==82 ? NULL : &r->entries[i+1];
    for (int i=0;i<80;i++) {
        r->ipv4[i].sin_family=AF_INET;
        r->ipv4[i].sin_addr.s_addr=htonl(0x7f000001u+(unsigned)i);
        r->entries[i].ai_family=AF_INET;
        r->entries[i].ai_addr=(struct sockaddr *)&r->ipv4[i];
        r->entries[i].ai_addrlen=sizeof r->ipv4[i];
    }
    r->entries[80].ai_family=AF_INET;
    r->entries[80].ai_addr=(struct sockaddr *)&r->ipv4[0];
    r->entries[80].ai_addrlen=sizeof r->ipv4[0];
    r->ipv6.sin6_family=AF_INET6;
    r->ipv6.sin6_addr.s6_addr[15]=1;
    r->entries[81].ai_family=AF_INET6;
    r->entries[81].ai_addr=(struct sockaddr *)&r->ipv6;
    r->entries[81].ai_addrlen=sizeof r->ipv6;
    r->entries[82].ai_family=AF_UNSPEC;
    *out=&r->entries[0]; return 0;
}
static void dns_freeaddrinfo(struct addrinfo *result) {
    free(result); dns_os_live--;
}
