class Events {
  static get publics {
    return """
      query events {      
          events (first: 20, isPublic: true) {
            totalCount,
            pageInfo {
              startCursor,
              endCursor,
              hasNextPage,
              hasPreviousPage
            },
            edges {
              node {
                id,
                name,
                address1,
                address2,
                description,
                scheduledAt,
                scheduledEnd,
                createdAt,
                updatedAt
              }
            }
          }
      }
    """;
  }
}
