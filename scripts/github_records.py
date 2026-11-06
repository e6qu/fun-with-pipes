"""Read complete GitHub job and artifact listings for evidence audits."""
import json


def records(request, path, field):
    """Read a complete, stable job/artifact listing before auditing it."""
    items = []
    page = 1
    total = None
    while True:
        response = json.loads(request(f'{path}?per_page=100&page={page}'))
        if total is None:
            total = response['total_count']
        assert response['total_count'] == total, (path, 'listing changed during audit')
        batch = response[field]
        assert batch or len(items) == total, (path, 'truncated listing')
        items.extend(batch)
        assert len({item['id'] for item in items}) == len(items), (path, 'duplicate records')
        assert len(items) <= total, (path, 'more records than declared')
        if len(items) == total:
            return items
        page += 1
