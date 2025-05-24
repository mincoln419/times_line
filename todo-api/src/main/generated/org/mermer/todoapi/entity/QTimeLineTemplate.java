package org.mermer.todoapi.entity;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;
import com.querydsl.core.types.dsl.PathInits;


/**
 * QTimeLineTemplate is a Querydsl query type for TimeLineTemplate
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QTimeLineTemplate extends EntityPathBase<TimeLineTemplate> {

    private static final long serialVersionUID = -987087608L;

    private static final PathInits INITS = PathInits.DIRECT2;

    public static final QTimeLineTemplate timeLineTemplate = new QTimeLineTemplate("timeLineTemplate");

    public final QBaseEntity _super;

    public final StringPath content = createString("content");

    //inherited
    public final DateTimePath<java.time.LocalDateTime> createAt;

    // inherited
    public final QTimeUser createdBy;

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final ListPath<TemplateTodoItem, QTemplateTodoItem> items = this.<TemplateTodoItem, QTemplateTodoItem>createList("items", TemplateTodoItem.class, QTemplateTodoItem.class, PathInits.DIRECT2);

    public final StringPath templateTitle = createString("templateTitle");

    public final QTimeUser timeUser;

    //inherited
    public final DateTimePath<java.time.LocalDateTime> updateAt;

    public QTimeLineTemplate(String variable) {
        this(TimeLineTemplate.class, forVariable(variable), INITS);
    }

    public QTimeLineTemplate(Path<? extends TimeLineTemplate> path) {
        this(path.getType(), path.getMetadata(), PathInits.getFor(path.getMetadata(), INITS));
    }

    public QTimeLineTemplate(PathMetadata metadata) {
        this(metadata, PathInits.getFor(metadata, INITS));
    }

    public QTimeLineTemplate(PathMetadata metadata, PathInits inits) {
        this(TimeLineTemplate.class, metadata, inits);
    }

    public QTimeLineTemplate(Class<? extends TimeLineTemplate> type, PathMetadata metadata, PathInits inits) {
        super(type, metadata, inits);
        this._super = new QBaseEntity(type, metadata, inits);
        this.createAt = _super.createAt;
        this.createdBy = _super.createdBy;
        this.timeUser = inits.isInitialized("timeUser") ? new QTimeUser(forProperty("timeUser")) : null;
        this.updateAt = _super.updateAt;
    }

}

