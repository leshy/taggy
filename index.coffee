Backbone = require 'backbone4000'
_ = require 'underscore'

exports.Taggy = Backbone.Model.extend4000
    initialize: -> if collection = @get 'collection' then @collection = collection

    query: (tags_yes=[], tags_no=[], callback) ->
        query = {}

        if tags_yes.constructor isnt Array then tags_yes = _.keys(tags_yes)
        if tags_no.constructor isnt Array then tags_no = _.keys(tags_no)

        console.log "rendering tags: ", tags_yes, tags_no
            
        _.map tags_yes, (tag) ->
            ret = {}; ret['tags.' + tag] = true
            query = ret

        _.map tags_no, (tag) ->
            ret = {}; ret['tags.' + tag] = { "$exists" : false }
            if query then query = { "$and" : [query, ret] } else query = ret

        posts = []
        
        @collection.findModels query, {sort: {created: -1}}, (post) ->
            if post then return posts.push post
            callback(posts)
            
        
        
        
                


