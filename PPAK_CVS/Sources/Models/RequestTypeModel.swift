//
//  RequestTypeModel.swift
//  PPAK_CVS
//
//  Created by 홍승현 on 2022/11/08.
//

import Foundation

struct RequestTypeModel: Codable {
  var cvs: CVSType
  var event: EventType
  var sort: SortType
  var offset: Int = 0
  var limit: Int = 10

  enum CodingKeys: String, CodingKey {
    case cvs
    case event
    case sort = "order-by"
    case offset
    case limit
  }
}
