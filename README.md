# Small Knowledge Base

This is a small Knowledge Base that will contain help articles divided by topics.

## Features

- Artciles should contain at least a single question and an answer
- Should be possible to apply CRUD operations on help articles
- Articles should be translated from English to German automatically using Machine translation
- Answers can contain HTML

### Implementation

Initially the core concept was to support Article creation along with specific topic tags, then creating
questions that link to answers, articles in that case.

This still needs more work, but so far the current implementation supports Article creation and translation.
It doesn't support the following:

- Search
- Caching
- Filtering based on language.
