import Models
import PointFreeRouter

extension Episode {
  public var subscriberOnly: Bool {
    return self.isSubscriberOnly(currentDate: Current.date())
  }
}

func reference(forEpisode episode: Episode, additionalBlurb: String) -> Episode.Reference {
  return Episode.Reference(
    author: "Brandon Williams & Stephen Celis",
    blurb: """
    \(additionalBlurb)

    > \(episode.blurb)
    """,
    link: url(to: .episode(.show(.left(episode.slug)))),
    publishedAt: episode.publishedAt,
    title: episode.fullTitle
  )
}
